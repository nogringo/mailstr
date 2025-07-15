import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nip19/nip19.dart';
import 'package:toastification/toastification.dart';
import 'package:mailstr/config.dart';
import 'package:mailstr/hex_to_base_36.dart';

class PayController extends GetxController {
  static PayController get to => Get.find();

  final RxBool searchingCode = false.obs;
  final RxString powStatus = ''.obs;
  final RxInt nonce = 0.obs;
  final RxDouble hashRate = 0.0.obs;
  final RxString miningDuration = '00:00'.obs;
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
      powStatus.value = 'Starting Proof of Work...';
      miningDuration.value = '00:00';
      pausedDuration = Duration.zero;
    } else {
      // Resuming
      powStatus.value = 'Resuming Proof of Work from nonce: ${nonce.value}';
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
    
    // Get email parameter to use as challenge
    final String email = Get.parameters['email'] ?? '';
    
    // Convert email to pubkey@domain format for POW challenge
    final emailParts = email.split('@');
    if (emailParts.length == 2) {
      final npubOrPubkey = emailParts[0];
      final domain = emailParts[1];
      
      String pubkey;
      if (npubOrPubkey.startsWith('npub')) {
        // Decode npub to get pubkey
        try {
          pubkey = Nip19.npubToHex(npubOrPubkey);
        } catch (e) {
          powStatus.value = 'Error decoding npub: $e';
          searchingCode.value = false;
          return;
        }
      } else if (npubOrPubkey.length == 64) {
        // Already a pubkey
        pubkey = npubOrPubkey;
      } else {
        // Convert from base36 to hex
        pubkey = base36ToHex(npubOrPubkey);
      }
      
      print('Original: $npubOrPubkey, Pubkey: $pubkey, Length: ${pubkey.length}');
      
      // Validate pubkey format and length
      if (pubkey.length != 64 || !RegExp(r'^[0-9a-fA-F]+$').hasMatch(pubkey)) {
        powStatus.value = 'Invalid pubkey format: length=${pubkey.length}, hex=${RegExp(r'^[0-9a-fA-F]+$').hasMatch(pubkey)}';
        searchingCode.value = false;
        return;
      }
      
      final pubkeyEmail = '$pubkey@$domain';
      _performProofOfWork(pubkeyEmail, difficulty);
    } else {
      powStatus.value = 'Invalid email format';
      searchingCode.value = false;
    }
  }

  void stopProofOfWork() {
    searchingCode.value = false;
    shouldStopPow = true;
    powTimer?.cancel();
    durationTimer?.cancel();
    powStatus.value = 'Proof of Work paused at nonce: ${nonce.value}';
    // Keep the current nonce and duration values
  }
  
  void resetProofOfWork() {
    searchingCode.value = false;
    shouldStopPow = true;
    powTimer?.cancel();
    durationTimer?.cancel();
    nonce.value = 0;
    miningDuration.value = '00:00';
    pausedDuration = Duration.zero;
    powStatus.value = 'Proof of Work reset';
    hashRate.value = 0.0;
  }
  
  Future<void> _performProofOfWork(String challenge, int difficulty) async {
    final startTime = DateTime.now();
    int attemptCount = 0;
    
    // Start hash rate calculation timer
    powTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      final elapsed = DateTime.now().difference(startTime).inSeconds;
      if (elapsed > 0) {
        hashRate.value = attemptCount / elapsed;
      }
    });
    
    // Perform proof of work in smaller batches to avoid blocking UI
    while (!shouldStopPow) {
      for (int i = 0; i < 1000; i++) {
        if (shouldStopPow) break;
        
        nonce.value++;
        attemptCount++;
        
        // Create hash of challenge + nonce
        final input = '$challenge:${nonce.value}';
        final bytes = utf8.encode(input);
        final hash = sha256.convert(bytes);
        final hashHex = hash.toString();
        
        // Check if hash meets difficulty requirement
        if (hashHex.startsWith('0' * difficulty)) {
          powTimer?.cancel();
          durationTimer?.cancel();
          searchingCode.value = false;
          powCompleted.value = true;
          powStatus.value = 'Proof of Work completed! Nonce: ${nonce.value}';
          
          // Create proof object
          final proof = {
            'challenge': challenge,
            'nonce': nonce.value,
            'hash': hashHex,
            'difficulty': difficulty,
            'duration': miningDuration.value,
          };
          
          // Call success handler with proof
          await payWithProofOfWork(proof);
          return;
        }
      }
      
      // Update status every 10 batches to reduce UI updates
      if (nonce.value % 10000 == 0) {
        powStatus.value = 'Searching... Nonce: ${nonce.value} | Hash rate: ${hashRate.value.toStringAsFixed(2)} H/s';
      }
      
      // Allow UI to update with minimal delay
      await Future.delayed(Duration(milliseconds: 1));
    }
  }

  Future<void> payWithCashu(String token) async {
    try {
      final email = Get.parameters['email'] ?? '';
      
      // Convert email to hex@domain format for API
      final emailParts = email.split('@');
      String apiEmail = email; // fallback
      
      if (emailParts.length == 2) {
        final npubOrPubkey = emailParts[0];
        final domain = emailParts[1];
        
        String pubkey;
        if (npubOrPubkey.startsWith('npub')) {
          try {
            pubkey = Nip19.npubToHex(npubOrPubkey);
            apiEmail = '$pubkey@$domain';
          } catch (e) {
            print('Error decoding npub for API: $e');
          }
        } else if (npubOrPubkey.length == 64) {
          // Already a pubkey
          apiEmail = email;
        } else {
          // Convert from base36 to hex
          pubkey = base36ToHex(npubOrPubkey);
          apiEmail = '$pubkey@$domain';
        }
      }
      
      Get.dialog(
        Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false,
      );
      
      final response = await http.post(
        Uri.parse(payWithCashuUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': apiEmail,
          'cashuToken': token,
        }),
      );

      Get.back(); // Close loading dialog
      
      print('Cashu Response: ${response.statusCode} - ${response.body}');
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        emailUnlocked.value = true;
        
        toastification.show(
          title: Text('Success'),
          description: Text(data['message'] ?? 'Payment accepted, email unlocked!'),
          type: ToastificationType.success,
          style: ToastificationStyle.fillColored,
          alignment: Alignment.bottomRight,
          autoCloseDuration: Duration(seconds: 5),
          applyBlurEffect: true,
          primaryColor: Get.theme.colorScheme.primary,
          backgroundColor: Get.theme.colorScheme.onPrimary,
          closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
        );
      } else {
        final error = jsonDecode(response.body);
        String errorMessage = error['error'] ?? 'Payment failed';
        
        // Show trusted mints if that's the error
        if (error['trustedMints'] != null) {
          errorMessage += '\n\nTrusted mints:\n${(error['trustedMints'] as List).join('\n')}';
        }
        
        toastification.show(
          title: Text('Error'),
          description: Text(errorMessage),
          type: ToastificationType.error,
          style: ToastificationStyle.fillColored,
          alignment: Alignment.bottomRight,
          autoCloseDuration: Duration(seconds: 8),
          applyBlurEffect: true,
          primaryColor: Get.theme.colorScheme.error,
          backgroundColor: Get.theme.colorScheme.onError,
          closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
        );
      }
    } catch (e) {
      Get.back(); // Close loading dialog if still open
      print('Error sending Cashu payment: $e');
      toastification.show(
        title: Text('Error'),
        description: Text('Failed to connect to server'),
        type: ToastificationType.error,
        style: ToastificationStyle.fillColored,
        alignment: Alignment.bottomRight,
        autoCloseDuration: Duration(seconds: 5),
        applyBlurEffect: true,
        primaryColor: Get.theme.colorScheme.error,
        backgroundColor: Get.theme.colorScheme.onError,
        closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
      );
    }
  }

  Future<void> payWithProofOfWork(Map<String, dynamic> proof) async {
    try {
      final email = Get.parameters['email'] ?? '';
      
      // Convert email to hex@domain format for API
      final emailParts = email.split('@');
      String apiEmail = email; // fallback
      
      if (emailParts.length == 2) {
        final npubOrPubkey = emailParts[0];
        final domain = emailParts[1];
        
        String pubkey;
        if (npubOrPubkey.startsWith('npub')) {
          try {
            pubkey = Nip19.npubToHex(npubOrPubkey);
            apiEmail = '$pubkey@$domain';
          } catch (e) {
            print('Error decoding npub for API: $e');
          }
        } else if (npubOrPubkey.length == 64) {
          // Already a pubkey
          apiEmail = email;
        } else {
          // Convert from base36 to hex
          pubkey = base36ToHex(npubOrPubkey);
          apiEmail = '$pubkey@$domain';
        }
      }
      
      final response = await http.post(
        Uri.parse(payWithProofOfWorkUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': apiEmail,
          'nonce': proof['nonce'].toString(),
        }),
      );

      print('POW Response: ${response.statusCode} - ${response.body}');
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        emailUnlocked.value = true;
        
        toastification.show(
          title: Text('Success'),
          description: Text(data['message'] ?? 'Email unlocked with Proof of Work!'),
          type: ToastificationType.success,
          style: ToastificationStyle.fillColored,
          alignment: Alignment.bottomRight,
          autoCloseDuration: Duration(seconds: 5),
          applyBlurEffect: true,
          primaryColor: Get.theme.colorScheme.primary,
          backgroundColor: Get.theme.colorScheme.onPrimary,
          closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
        );
      } else {
        final error = jsonDecode(response.body);
        toastification.show(
          title: Text('Error'),
          description: Text(error['error'] ?? 'Failed to verify proof of work'),
          type: ToastificationType.error,
          style: ToastificationStyle.fillColored,
          alignment: Alignment.bottomRight,
          autoCloseDuration: Duration(seconds: 5),
          applyBlurEffect: true,
          primaryColor: Get.theme.colorScheme.error,
          backgroundColor: Get.theme.colorScheme.onError,
          closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
        );
      }
    } catch (e) {
      print('Error sending POW: $e');
      toastification.show(
        title: Text('Error'),
        description: Text('Failed to connect to server'),
        type: ToastificationType.error,
        style: ToastificationStyle.fillColored,
        alignment: Alignment.bottomRight,
        autoCloseDuration: Duration(seconds: 5),
        applyBlurEffect: true,
        primaryColor: Get.theme.colorScheme.error,
        backgroundColor: Get.theme.colorScheme.onError,
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