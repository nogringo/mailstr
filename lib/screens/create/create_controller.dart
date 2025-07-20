import 'package:flutter/material.dart';
import 'package:mailstr/l10n/app_localizations.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nip01/nip01.dart';
import 'package:nip19/nip19.dart';
import 'package:toastification/toastification.dart';
import 'package:mailstr/app_routes.dart';
import 'package:mailstr/config.dart';
import 'package:mailstr/hex_to_base_36.dart';

class CreateController extends GetxController {
  static CreateController get to => Get.find();

  KeyPair keypair = KeyPair.generate();

  String get npubEmail => "${keypair.npub}@$emailDomain";
  String get pubkeyEmail => "${keypair.publicKey}@$emailDomain";
  String get compactEmail => "${hexToBase36(keypair.publicKey)}@$emailDomain";

  void newEmail() {
    keypair = KeyPair.generate();
    update();
  }

  void copy(String text) {
    Clipboard.setData(ClipboardData(text: text));
    toastification.show(
      title: Text(AppLocalizations.of(Get.context!)!.copied),
      alignment: Alignment.bottomRight,
      style: ToastificationStyle.fillColored,
      icon: Icon(Icons.copy),
      applyBlurEffect: true,
      primaryColor: Get.theme.colorScheme.primaryContainer,
      backgroundColor: Get.theme.colorScheme.onPrimaryContainer,
      autoCloseDuration: Duration(seconds: 3),
      closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
    );
  }

  void payNow() {
    Get.toNamed(
      '${AppRoutes.unlockEmail}/${keypair.npub}',
    );
  }
}
