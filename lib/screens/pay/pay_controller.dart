import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:toastification/toastification.dart';
import 'package:mailstr/config.dart';
import 'package:mailstr/l10n/app_localizations.dart';

class PayController extends GetxController {
  static PayController get to => Get.find();

  final RxBool searchingCode = false.obs;
  final RxString powStatus = ''.obs;
  final RxInt nonce = 0.obs;
  final RxDouble hashRate = 0.0.obs;
  final RxString miningDuration = '00:00'.obs;
  final RxString estimatedTimeRemaining = '--:--'.obs;
  final RxDouble powProgress = 0.0.obs;
  final RxBool powCompleted = false.obs;
  final RxBool emailUnlocked = false.obs;
  
  Timer? powTimer;
  Timer? durationTimer;
  bool shouldStopPow = false;
  DateTime? miningStartTime;
  Duration pausedDuration = Duration.zero;
  
  void startProofOfWork() {
    searchingCode.value = true;
    shouldStopPow = false;
    
    // Check if this is a resume or a fresh start
    if (nonce.value == 0) {
      // Fresh start
      powStatus.value = AppLocalizations.of(Get.context!)!.startingProofOfWork;
      miningDuration.value = '00:00';
      pausedDuration = Duration.zero;
    } else {
      // Resuming
      powStatus.value = AppLocalizations.of(Get.context!)!.resumingProofOfWork(nonce.value);
      // Parse the current duration to preserve it
      final parts = miningDuration.value.split(':');
      if (parts.length == 2) {
        pausedDuration = Duration(
          minutes: int.tryParse(parts[0]) ?? 0,
          seconds: int.tryParse(parts[1]) ?? 0,
        );
      }
    }
    
    miningStartTime = DateTime.now();
    
    // Start duration timer
    durationTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      final elapsed = DateTime.now().difference(miningStartTime!) + pausedDuration;
      final minutes = elapsed.inMinutes.toString().padLeft(2, '0');
      final seconds = (elapsed.inSeconds % 60).toString().padLeft(2, '0');
      miningDuration.value = '$minutes:$seconds';
    });
    
    // Get email parameter
    final String email = Get.parameters['email'] ?? '';
    
    if (email.isEmpty) {
      powStatus.value = AppLocalizations.of(Get.context!)!.invalidEmailFormat;
      searchingCode.value = false;
      return;
    }
    
    // Use email directly as challenge
    _performProofOfWork(email, difficulty);
  }

  void stopProofOfWork() {
    searchingCode.value = false;
    shouldStopPow = true;
    powTimer?.cancel();
    durationTimer?.cancel();
    powStatus.value = AppLocalizations.of(Get.context!)!.proofOfWorkPaused(nonce.value);
    estimatedTimeRemaining.value = '--:--';
    // Keep the current nonce, duration and progress values
  }
  
  void resetProofOfWork() {
    searchingCode.value = false;
    shouldStopPow = true;
    powTimer?.cancel();
    durationTimer?.cancel();
    nonce.value = 0;
    miningDuration.value = '00:00';
    estimatedTimeRemaining.value = '--:--';
    powProgress.value = 0.0;
    pausedDuration = Duration.zero;
    powStatus.value = AppLocalizations.of(Get.context!)!.proofOfWorkReset;
    hashRate.value = 0.0;
  }
  
  Future<void> _performProofOfWork(String email, int difficulty) async {
    final startTime = DateTime.now();
    int attemptCount = 0;
    
    // Start hash rate calculation timer
    powTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      final elapsed = DateTime.now().difference(startTime).inSeconds;
      if (elapsed > 0) {
        hashRate.value = attemptCount / elapsed;
        
        // Calculate estimated time remaining and progress
        if (hashRate.value > 0) {
          // Expected number of attempts for the given difficulty (2^(4*difficulty) on average)
          final expectedAttempts = 1 << (4 * difficulty);
          final remainingAttempts = expectedAttempts - nonce.value;
          
          // Calculate progress (0.0 to 1.0)
          powProgress.value = nonce.value / expectedAttempts;
          
          if (remainingAttempts > 0) {
            final estimatedSecondsRemaining = remainingAttempts / hashRate.value;
            
            if (estimatedSecondsRemaining < 3600) {
              // Less than an hour, show MM:SS
              final minutes = (estimatedSecondsRemaining / 60).floor();
              final seconds = (estimatedSecondsRemaining % 60).floor();
              estimatedTimeRemaining.value = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
            } else {
              // More than an hour, show HH:MM
              final hours = (estimatedSecondsRemaining / 3600).floor();
              final minutes = ((estimatedSecondsRemaining % 3600) / 60).floor();
              estimatedTimeRemaining.value = '${hours}h ${minutes.toString().padLeft(2, '0')}m';
            }
          } else {
            estimatedTimeRemaining.value = '00:00';
          }
        }
      }
    });
    
    // Perform proof of work in smaller batches to avoid blocking UI
    while (!shouldStopPow) {
      for (int i = 0; i < 1000; i++) {
        if (shouldStopPow) break;
        
        nonce.value++;
        attemptCount++;
        
        // Create hash of email + nonce
        final input = '$email:${nonce.value}';
        final bytes = utf8.encode(input);
        final hash = sha256.convert(bytes);
        final hashHex = hash.toString();
        
        // Check if hash meets difficulty requirement
        if (hashHex.startsWith('0' * difficulty)) {
          powTimer?.cancel();
          durationTimer?.cancel();
          searchingCode.value = false;
          powCompleted.value = true;
          powStatus.value = AppLocalizations.of(Get.context!)!.proofOfWorkCompletedWithNonce(nonce.value);
          
          // Call success handler with proof
          await payWithProofOfWork(email, nonce.value);
          return;
        }
      }
      
      // Update status to show we're still searching
      powStatus.value = AppLocalizations.of(Get.context!)!.searchingForCode;
      
      // Allow UI to update with minimal delay
      await Future.delayed(Duration(milliseconds: 1));
    }
  }

  Future<void> payWithCashu(String token) async {
    try {
      final email = Get.parameters['email'] ?? '';
      
      Get.dialog(
        Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false,
      );
      
      final response = await http.post(
        Uri.parse(unlockWithCashuUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'cashuToken': token,
        }),
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
            data['message'] ?? AppLocalizations.of(Get.context!)!.paymentAcceptedEmailUnlocked,
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
        String errorMessage = error['error'] ?? AppLocalizations.of(Get.context!)!.paymentFailed;
        
        // Show trusted mints if that's the error
        if (error['trustedMints'] != null) {
          errorMessage += '${AppLocalizations.of(Get.context!)!.trustedMints}${(error['trustedMints'] as List).join('\n')}';
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

  Future<void> payWithProofOfWork(String email, int nonce) async {
    try {
      final response = await http.post(
        Uri.parse(unlockWithProofOfWorkUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'nonce': nonce.toString(),
        }),
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
            data['message'] ?? AppLocalizations.of(Get.context!)!.emailUnlockedWithProofOfWork,
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
            error['error'] ?? AppLocalizations.of(Get.context!)!.failedToVerifyProofOfWork,
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
  
  @override
  void onClose() {
    powTimer?.cancel();
    durationTimer?.cancel();
    super.onClose();
  }
}