import 'dart:convert';

import 'package:get/get.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk_ui/ndk_ui.dart';
import 'package:mailstr/config.dart';

class MailboxController extends GetxController {
  static MailboxController get to => Get.find();

  RxInt selectedIndex = 0.obs;
  RxList<Nip01Event> messages = <Nip01Event>[].obs;
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
      // If session was restored and user is logged in, start listening for messages
      listenMessages();
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
