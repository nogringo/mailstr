import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ndk/ndk.dart';
import 'package:nip19/nip19.dart';
import 'package:mailstr/config.dart';
import 'package:mailstr/hex_to_base_36.dart';
import 'package:mailstr/controllers/auth_controller.dart';

class MailboxController extends GetxController {
  static MailboxController get to => Get.find();

  RxInt selectedIndex = 0.obs;
  RxList<Nip01Event> messages = <Nip01Event>[].obs;
  RxList<String> aliases = <String>[].obs;
  NdkResponse? _messagesSubscription;

  Ndk get ndk => Get.find<Ndk>();

  @override
  void onInit() {
    super.onInit();
    _initializeIfLoggedIn();
    _listenToAuthChanges();
  }

  void _initializeIfLoggedIn() {
    // Initialize mailbox if user is already logged in
    if (ndk.accounts.isLoggedIn) {
      listenMessages();
      fetchAliases();
    }
  }

  void _listenToAuthChanges() {
    // Listen to auth state changes and initialize/cleanup accordingly
    final authController = Get.find<AuthController>();
    ever(authController.isLoggedInRx, (bool isLoggedIn) {
      if (isLoggedIn) {
        // User logged in - start listening for messages and fetch aliases
        listenMessages();
        fetchAliases();
      } else {
        // User logged out - cleanup subscriptions
        cancelMessagesSubscription();
        messages.clear();
        aliases.clear();
      }
    });
  }

  void listenMessages() {
    if (!ndk.accounts.isLoggedIn) return;
    
    // Check if subscription already exists to prevent multiple subscriptions
    if (_messagesSubscription != null) {
      return;
    }

    // Calculate timestamp for 7 days ago
    final sevenDaysAgo = DateTime.now().subtract(Duration(days: 3));
    final sinceTimestamp = sevenDaysAgo.millisecondsSinceEpoch ~/ 1000;

    _messagesSubscription = ndk.requests.subscription(
      filters: [
        Filter(
          kinds: [1059], 
          pTags: [ndk.accounts.getPublicKey()!],
          since: sinceTimestamp,
        ),
      ],
      explicitRelays: relays,
      cacheRead: true,
      cacheWrite: true,
    );
    print("req");

    _messagesSubscription!.stream.listen((giftWrap) async {
      late Nip01Event unwrapped;
      try {
        unwrapped = await ndk.giftWrap.unwrapEvent(wrappedEvent: giftWrap);
      } catch (e) {
        return;
      }

      if (unwrapped.pubKey != serverPubkey) return;

      final unwrappedDecryptedContent = await ndk.accounts
          .getLoggedAccount()!
          .signer
          .decryptNip44(
            ciphertext: unwrapped.content,
            senderPubKey: unwrapped.pubKey,
          );

      final messageEventJson = jsonDecode(unwrappedDecryptedContent!);
      final messageEvent = Nip01Event(
        pubKey: messageEventJson["pubkey"],
        kind: messageEventJson["kind"],
        tags: [],
        content: messageEventJson["content"],
        createdAt: messageEventJson["created_at"],
      );

      if (messages.where((e) => e.id == messageEvent.id).isEmpty) {
        messages.add(messageEvent);
        // Sort messages by createdAt in descending order (newest first)
        messages.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      }
    });
  }

  Future<void> fetchAliases() async {
    if (!ndk.accounts.isLoggedIn) return;

    final pubkey = ndk.accounts.getPublicKey();
    if (pubkey == null) return;

    // Clear existing aliases
    aliases.clear();

    try {
      // Generate the 3 standard aliases
      final npub = Nip19.npubFromHex(pubkey);
      final npubEmail = "$npub@$emailDomain";
      final pubkeyEmail = "$pubkey@$emailDomain";
      final compactEmail = "${hexToBase36(pubkey)}@$emailDomain";

      // Add standard aliases
      aliases.addAll([npubEmail, pubkeyEmail, compactEmail]);
    } catch (e) {
      // Fallback to simple hex alias
      aliases.add('${pubkey.substring(0, 8)}@$emailDomain');
    }

    // Fetch registered addresses from server using signed Nostr event
    try {
      // Create a signed Nostr event for authentication
      final signer = ndk.accounts.getLoggedAccount()?.signer;
      if (signer == null) return;

      final event = Nip01Event(
        pubKey: pubkey,
        kind: 1,
        tags: [],
        content: 'get-addresses',
        createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      );
      await signer.sign(event);

      final response = await http.post(
        Uri.parse(getAddressesByPubkeyUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'event': event.toJson()}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is List) {
          for (final address in data) {
            // The response is a list of address strings like "name@domain.com"
            if (!aliases.contains(address)) {
              aliases.add(address);
            }
          }
        }
      }
    } catch (e) {
      // Silently fail - we still have the standard aliases
    }
  }

  Future<bool> unregisterNip05(String name) async {
    if (!ndk.accounts.isLoggedIn) return false;

    final pubkey = ndk.accounts.getPublicKey();
    if (pubkey == null) return false;

    try {
      // Create a signed Nostr event for authentication
      final signer = ndk.accounts.getLoggedAccount()?.signer;
      if (signer == null) return false;

      final fullAddress = '$name@$emailDomain';
      final event = Nip01Event(
        pubKey: pubkey,
        kind: 1,
        tags: [],
        content: 'unregister:$fullAddress',
        createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      );

      await signer.sign(event);

      final response = await http.post(
        Uri.parse(removeAddressUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'event': event.toJson()}),
      );

      if (response.statusCode == 200) {
        // Remove from aliases list
        aliases.remove(fullAddress);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  void cancelMessagesSubscription() {
    if (_messagesSubscription != null) {
      ndk.requests.closeSubscription(_messagesSubscription!.requestId);
      _messagesSubscription = null;
    }
  }

  @override
  void onClose() {
    cancelMessagesSubscription();
    super.onClose();
  }
}
