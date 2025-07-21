import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ndk/ndk.dart';
import 'package:nip19/nip19.dart';
import 'package:toastification/toastification.dart';
import 'package:mailstr/config.dart';
import 'package:mailstr/screens/mailbox/mailbox_controller.dart';

class Nip05Controller extends GetxController {
  static Nip05Controller get to => Get.find();

  final nameController = TextEditingController();
  final pubkeyController = TextEditingController();
  
  RxBool isLoading = false.obs;
  RxBool isNip05 = false.obs;

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

  void generateRandomUsername() {
    // Lists of words for generating random usernames
    final adjectives = [
      'happy', 'sunny', 'swift', 'bright', 'cool', 'smart', 'lucky',
      'cosmic', 'cyber', 'digital', 'electric', 'neon', 'pixel', 'quantum',
      'stellar', 'turbo', 'ultra', 'vivid', 'wild', 'zen', 'alpha',
      'beta', 'gamma', 'delta', 'echo', 'nova', 'omega', 'sigma',
      'crypto', 'lightning', 'thunder', 'storm', 'flame', 'frost',
      'shadow', 'mystic', 'ninja', 'samurai', 'phoenix', 'dragon'
    ];
    
    final nouns = [
      'fox', 'wolf', 'bear', 'eagle', 'hawk', 'lion', 'tiger',
      'rider', 'walker', 'runner', 'hunter', 'seeker', 'finder',
      'coder', 'hacker', 'builder', 'maker', 'creator', 'artist',
      'wizard', 'sage', 'knight', 'warrior', 'champion', 'hero',
      'star', 'moon', 'sun', 'comet', 'meteor', 'galaxy',
      'wave', 'tide', 'storm', 'bolt', 'spark', 'flash'
    ];
    
    // Generate random indices using proper random
    final random = Random();
    final adjIndex = random.nextInt(adjectives.length);
    final nounIndex = random.nextInt(nouns.length);
    final number = random.nextInt(1000);
    
    // Create username
    final username = '${adjectives[adjIndex]}${nouns[nounIndex]}$number';
    
    // Set the username in the text field
    nameController.text = username;
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
        Uri.parse(addAddressUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'pubkey': hexPubkey,
          'domain': emailDomain,
          'nip05': isNip05.value,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          _showSuccessToast('NIP-05 registered successfully!');
          
          // Add the new alias to the mailbox controller
          try {
            final mailboxController = Get.find<MailboxController>();
            final newAlias = '$name@$emailDomain';
            if (!mailboxController.aliases.contains(newAlias)) {
              mailboxController.aliases.add(newAlias);
            }
          } catch (e) {
            // Mailbox controller might not be initialized, that's ok
          }
          
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
      primaryColor: Get.theme.colorScheme.primary,
      backgroundColor: Get.theme.colorScheme.onPrimary,
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
      primaryColor: Get.theme.colorScheme.error,
      backgroundColor: Get.theme.colorScheme.onError,
      autoCloseDuration: Duration(seconds: 4),
      closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
    );
  }
}