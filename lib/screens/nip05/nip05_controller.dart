import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ndk/ndk.dart';
import 'package:nip19/nip19.dart';
import 'package:toastification/toastification.dart';
import 'package:mailstr/config.dart';

class Nip05Controller extends GetxController {
  static Nip05Controller get to => Get.find();

  final nameController = TextEditingController();
  final pubkeyController = TextEditingController();
  
  RxBool isLoading = false.obs;
  RxBool isPrivate = false.obs;

  Ndk get ndk => Get.find<Ndk>();

  @override
  void onInit() {
    super.onInit();
    // Pre-fill with user's pubkey if logged in
    final userPubkey = ndk.accounts.getPublicKey();
    if (userPubkey != null) {
      pubkeyController.text = userPubkey;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    pubkeyController.dispose();
    super.onClose();
  }

  Future<void> registerNip05() async {
    final name = nameController.text.trim();
    final pubkey = pubkeyController.text.trim();
    
    if (name.isEmpty) {
      _showErrorToast('Please enter a name');
      return;
    }

    if (pubkey.isEmpty) {
      _showErrorToast('Please enter a public key');
      return;
    }

    // Validate name format
    if (!RegExp(r'^[a-zA-Z0-9_-]+$').hasMatch(name)) {
      _showErrorToast('Name can only contain letters, numbers, hyphens and underscores');
      return;
    }

    // Validate pubkey format (64 hex chars or npub)
    String hexPubkey = pubkey;
    if (pubkey.startsWith('npub')) {
      try {
        hexPubkey = Nip19.npubToHex(pubkey);
      } catch (e) {
        _showErrorToast('Invalid npub format');
        return;
      }
    } else if (!RegExp(r'^[0-9a-fA-F]{64}$').hasMatch(pubkey)) {
      _showErrorToast('Invalid public key format (use hex or npub)');
      return;
    }

    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse(payWithCashuUrl.replaceAll('/payWithCashu', '/registerNip05')),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'pubkey': hexPubkey,
          'domain': emailDomain,
          'relays': relays,
          'private': isPrivate.value,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          _showSuccessToast('NIP-05 registered successfully!');
          Get.back();
        } else {
          _showErrorToast(data['error'] ?? 'Registration failed');
        }
      } else if (response.statusCode == 409) {
        _showErrorToast('Name already taken for this domain');
      } else {
        final errorData = jsonDecode(response.body);
        _showErrorToast(errorData['error'] ?? 'Registration failed');
      }
    } catch (e) {
      _showErrorToast('Network error: Please check your connection');
    } finally {
      isLoading.value = false;
    }
  }

  void _showSuccessToast(String message) {
    toastification.show(
      title: Text(message),
      alignment: Alignment.bottomRight,
      style: ToastificationStyle.fillColored,
      icon: Icon(Icons.check_circle),
      applyBlurEffect: true,
      primaryColor: Colors.green,
      backgroundColor: Colors.white,
      autoCloseDuration: Duration(seconds: 3),
      closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
    );
  }

  void _showErrorToast(String message) {
    toastification.show(
      title: Text(message),
      alignment: Alignment.bottomRight,
      style: ToastificationStyle.fillColored,
      icon: Icon(Icons.error),
      applyBlurEffect: true,
      primaryColor: Colors.red,
      backgroundColor: Colors.white,
      autoCloseDuration: Duration(seconds: 4),
      closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
    );
  }
}