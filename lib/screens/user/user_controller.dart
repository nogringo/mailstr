import 'package:get/get.dart';
import 'package:ndk/ndk.dart';
import 'package:nip19/nip19.dart';
import 'package:flutter/services.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter/material.dart';
import 'package:mailstr/l10n/app_localizations.dart';

class UserController extends GetxController {
  static UserController get to => Get.find();

  Ndk get ndk => Get.find<Ndk>();
  
  // User profile data
  RxString pubkey = ''.obs;
  RxString npub = ''.obs;
  RxString displayName = ''.obs;
  RxString about = ''.obs;
  RxString picture = ''.obs;
  RxString banner = ''.obs;
  RxString website = ''.obs;
  RxString nip05 = ''.obs;
  RxString lud16 = ''.obs;
  
  // Loading state
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  void loadUserProfile() {
    isLoading.value = true;
    
    final userPubkey = ndk.accounts.getPublicKey();
    if (userPubkey != null) {
      pubkey.value = userPubkey;
      
      try {
        npub.value = Nip19.npubFromHex(userPubkey);
      } catch (e) {
        npub.value = userPubkey;
      }
      
      // Load user metadata from NDK
      _loadUserMetadata(userPubkey);
    }
    
    isLoading.value = false;
  }

  void _loadUserMetadata(String pubkey) {
    // This would typically fetch user metadata from relays
    // For now, we'll set some placeholder values
    displayName.value = AppLocalizations.of(Get.context!)!.nostrUser;
    about.value = AppLocalizations.of(Get.context!)!.welcomeToMyNostrProfile;
    // Other fields would be loaded from user's metadata event
  }

  void copyToClipboard(String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    toastification.show(
      title: Text(AppLocalizations.of(Get.context!)!.copiedToClipboard(label)),
      alignment: Alignment.bottomRight,
      style: ToastificationStyle.fillColored,
      icon: Icon(Icons.copy),
      applyBlurEffect: true,
      primaryColor: Get.theme.colorScheme.primary,
      backgroundColor: Get.theme.colorScheme.onPrimary,
      autoCloseDuration: Duration(seconds: 2),
      closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
    );
  }

  String get truncatedPubkey {
    if (pubkey.value.length > 16) {
      return '${pubkey.value.substring(0, 8)}...${pubkey.value.substring(pubkey.value.length - 8)}';
    }
    return pubkey.value;
  }

  String get truncatedNpub {
    if (npub.value.length > 16) {
      return '${npub.value.substring(0, 8)}...${npub.value.substring(npub.value.length - 8)}';
    }
    return npub.value;
  }
}