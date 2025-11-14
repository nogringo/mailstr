import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ndk/ndk.dart';
import 'package:toastification/toastification.dart';
import 'package:mailstr/config.dart';
import 'package:mailstr/l10n/app_localizations.dart';
import 'package:ndk/shared/nips/nip01/bip340.dart';

class PayController extends GetxController {
  static PayController get to => Get.find();

  final RxBool searchingCode = false.obs;
  final RxString powStatus = ''.obs;
  final RxBool powCompleted = false.obs;
  final RxBool emailUnlocked = false.obs;

  void startProofOfWork() {
    searchingCode.value = true;
    powStatus.value = AppLocalizations.of(Get.context!)!.startingProofOfWork;

    // Get email parameter
    final String email = Get.parameters['email'] ?? '';

    if (email.isEmpty) {
      powStatus.value = AppLocalizations.of(Get.context!)!.invalidEmailFormat;
      searchingCode.value = false;
      return;
    }

    // Start the payment process
    payWithProofOfWork(email);
  }

  Future<void> payWithCashu(String token) async {
    try {
      final email = Get.parameters['email'] ?? '';

      Get.dialog(
        Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      final response = await http.post(
        Uri.parse(unlockWithCashuUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'cashuToken': token}),
      );

      Get.back(); // Close loading dialog

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        emailUnlocked.value = true;

        toastification.show(
          title: Text(
            AppLocalizations.of(Get.context!)!.success,
            style: TextStyle(color: Get.theme.colorScheme.onPrimaryContainer),
          ),
          description: Text(
            data['message'] ??
                AppLocalizations.of(Get.context!)!.paymentAcceptedEmailUnlocked,
            style: TextStyle(color: Get.theme.colorScheme.onPrimaryContainer),
          ),
          type: ToastificationType.success,
          style: ToastificationStyle.fillColored,
          alignment: Alignment.bottomRight,
          autoCloseDuration: Duration(seconds: 5),
          applyBlurEffect: true,
          primaryColor: Get.theme.colorScheme.primary,
          backgroundColor: Get.theme.colorScheme.primaryContainer,
          foregroundColor: Get.theme.colorScheme.onPrimaryContainer,
          closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
        );
      } else {
        final error = jsonDecode(response.body);
        String errorMessage =
            error['error'] ?? AppLocalizations.of(Get.context!)!.paymentFailed;

        // Show trusted mints if that's the error
        if (error['trustedMints'] != null) {
          errorMessage +=
              '${AppLocalizations.of(Get.context!)!.trustedMints}${(error['trustedMints'] as List).join('\n')}';
        }

        toastification.show(
          title: Text(
            AppLocalizations.of(Get.context!)!.error,
            style: TextStyle(color: Get.theme.colorScheme.onPrimaryContainer),
          ),
          description: Text(
            errorMessage,
            style: TextStyle(color: Get.theme.colorScheme.onPrimaryContainer),
          ),
          type: ToastificationType.error,
          style: ToastificationStyle.fillColored,
          alignment: Alignment.bottomRight,
          autoCloseDuration: Duration(seconds: 8),
          applyBlurEffect: true,
          primaryColor: Get.theme.colorScheme.error,
          backgroundColor: Get.theme.colorScheme.primaryContainer,
          foregroundColor: Get.theme.colorScheme.onPrimaryContainer,
          closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
        );
      }
    } catch (e) {
      Get.back(); // Close loading dialog if still open
      toastification.show(
        title: Text(
          AppLocalizations.of(Get.context!)!.error,
          style: TextStyle(color: Get.theme.colorScheme.onPrimaryContainer),
        ),
        description: Text(
          AppLocalizations.of(Get.context!)!.failedToConnectToServer,
          style: TextStyle(color: Get.theme.colorScheme.onPrimaryContainer),
        ),
        type: ToastificationType.error,
        style: ToastificationStyle.fillColored,
        alignment: Alignment.bottomRight,
        autoCloseDuration: Duration(seconds: 5),
        applyBlurEffect: true,
        primaryColor: Get.theme.colorScheme.error,
        backgroundColor: Get.theme.colorScheme.primaryContainer,
        foregroundColor: Get.theme.colorScheme.onPrimaryContainer,
        closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
      );
    }
  }

  Future<void> payWithProofOfWork(String email) async {
    try {
      // Generate a keypair for this event
      final keypair = Bip340.generatePrivateKey();

      // Create the base event with email as content
      final baseEvent = Nip01Event(
        pubKey: keypair.publicKey,
        kind: 1,
        tags: [],
        content: email,
        createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      );

      // Use NDK's minePoW method which handles the mining internally
      final minedEvent = baseEvent.minePoW(difficulty);

      searchingCode.value = false;
      powCompleted.value = true;
      powStatus.value = AppLocalizations.of(Get.context!)!.proofOfWorkCompleted;

      // Sign the event
      final signer = Bip340EventSigner(
        privateKey: keypair.privateKey,
        publicKey: keypair.publicKey,
      );
      await signer.sign(minedEvent);

      // Submit the signed event to the backend
      final response = await http.post(
        Uri.parse(unlockWithProofOfWorkUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'event': minedEvent.toJson()}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        emailUnlocked.value = true;

        toastification.show(
          title: Text(
            AppLocalizations.of(Get.context!)!.success,
            style: TextStyle(color: Get.theme.colorScheme.onPrimaryContainer),
          ),
          description: Text(
            data['message'] ??
                AppLocalizations.of(Get.context!)!.emailUnlockedWithProofOfWork,
            style: TextStyle(color: Get.theme.colorScheme.onPrimaryContainer),
          ),
          type: ToastificationType.success,
          style: ToastificationStyle.fillColored,
          alignment: Alignment.bottomRight,
          autoCloseDuration: Duration(seconds: 5),
          applyBlurEffect: true,
          primaryColor: Get.theme.colorScheme.primary,
          backgroundColor: Get.theme.colorScheme.primaryContainer,
          foregroundColor: Get.theme.colorScheme.onPrimaryContainer,
          closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
        );
      } else {
        final error = jsonDecode(response.body);
        toastification.show(
          title: Text(
            AppLocalizations.of(Get.context!)!.error,
            style: TextStyle(color: Get.theme.colorScheme.onPrimaryContainer),
          ),
          description: Text(
            error['error'] ??
                AppLocalizations.of(Get.context!)!.failedToVerifyProofOfWork,
            style: TextStyle(color: Get.theme.colorScheme.onPrimaryContainer),
          ),
          type: ToastificationType.error,
          style: ToastificationStyle.fillColored,
          alignment: Alignment.bottomRight,
          autoCloseDuration: Duration(seconds: 5),
          applyBlurEffect: true,
          primaryColor: Get.theme.colorScheme.error,
          backgroundColor: Get.theme.colorScheme.primaryContainer,
          foregroundColor: Get.theme.colorScheme.onPrimaryContainer,
          closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
        );
      }
    } catch (e) {
      toastification.show(
        title: Text(
          AppLocalizations.of(Get.context!)!.error,
          style: TextStyle(color: Get.theme.colorScheme.onPrimaryContainer),
        ),
        description: Text(
          AppLocalizations.of(Get.context!)!.failedToConnectToServer,
          style: TextStyle(color: Get.theme.colorScheme.onPrimaryContainer),
        ),
        type: ToastificationType.error,
        style: ToastificationStyle.fillColored,
        alignment: Alignment.bottomRight,
        autoCloseDuration: Duration(seconds: 5),
        applyBlurEffect: true,
        primaryColor: Get.theme.colorScheme.error,
        backgroundColor: Get.theme.colorScheme.primaryContainer,
        foregroundColor: Get.theme.colorScheme.onPrimaryContainer,
        closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
      );
    }
  }
}
