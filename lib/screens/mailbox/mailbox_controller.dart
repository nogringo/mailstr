import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk_ui/ndk_ui.dart';
import 'package:nip19/nip19.dart';
import 'package:mailstr/config.dart';
import 'package:mailstr/hex_to_base_36.dart';

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
    _restoreSessionAndListen();
  }

  Future<void> _restoreSessionAndListen() async {
    // Try to restore last session
    final wasRestored = await nRestoreLastSession(ndk);

    if (wasRestored && ndk.accounts.isLoggedIn) {
      // If session was restored and user is logged in, start listening for messages and fetch aliases
      listenMessages();
      fetchAliases();
    }
  }

  void listenMessages() {
    if (!ndk.accounts.isLoggedIn) return;

    _messagesSubscription = ndk.requests.subscription(
      filters: [
        Filter(kinds: [1059], pTags: [ndk.accounts.getPublicKey()!]),
      ],
      explicitRelays: relays,
      cacheRead: true,
      cacheWrite: true,
    );

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

      messages.addIf(
        messages.where((e) => e.id == messageEvent.id).isEmpty,
        messageEvent,
      );
    });
  }

  Future<void> fetchAliases() async {
    if (!ndk.accounts.isLoggedIn) return;
    
    final pubkey = ndk.accounts.getPublicKey();
    if (pubkey == null) return;

    try {
      // Generate the 3 standard aliases
      final npub = Nip19.npubFromHex(pubkey);
      final npubEmail = "$npub@$emailDomain";
      final pubkeyEmail = "$pubkey@$emailDomain";
      final compactEmail = "${hexToBase36(pubkey)}@$emailDomain";
      
      aliases.value = [
        npubEmail,
        pubkeyEmail,
        compactEmail,
      ];
    } catch (e) {
      // Fallback to simple hex alias
      aliases.value = ['${pubkey.substring(0, 8)}@$emailDomain'];
    }
  }

  void showCreateAliasDialog(BuildContext context) {
    final TextEditingController aliasController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create New Alias'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: aliasController,
              decoration: const InputDecoration(
                labelText: 'Alias name',
                hintText: 'Enter alias name (without @domain)',
                border: OutlineInputBorder(),
              ),
              autofocus: true,
            ),
            const SizedBox(height: 8),
            Text(
              'This will create: [alias]@$emailDomain',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final aliasName = aliasController.text.trim();
              if (aliasName.isNotEmpty) {
                createNewAlias(aliasName);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  Future<void> createNewAlias(String aliasName) async {
    if (!ndk.accounts.isLoggedIn) return;
    
    try {
      final newAlias = '$aliasName@$emailDomain';
      
      // TODO: Call API to register the new alias on the server
      // For now, just add it to the local list
      if (!aliases.contains(newAlias)) {
        aliases.add(newAlias);
      }
    } catch (e) {
      // Show error toast
      print('Error creating alias: $e');
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
