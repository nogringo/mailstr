import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailstr/app_routes.dart';
import 'package:mailstr/controllers/auth_controller.dart';
import 'package:ndk/ndk.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();

  void onLoginSuccess() {
    // Update auth state
    final authController = Get.find<AuthController>();
    authController.updateAuthState();
    
    // Double check if now logged in
    if (!authController.isLoggedIn) {
      // Login didn't succeed, don't navigate
      return;
    }
    
    // Check if we have a return route
    final dynamic args = Get.arguments;
    final String? returnRoute = args?['returnRoute'];
    
    // If returning to mailbox, check signing capability
    if (returnRoute == AppRoutes.mailbox) {
      final ndk = Get.find<Ndk>();
      if (!ndk.accounts.canSign) {
        // Show error and redirect to home instead
        Get.snackbar(
          'Limited Access',
          'You logged in with a read-only method. Mailbox requires signing capability.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Get.theme.colorScheme.errorContainer,
          colorText: Get.theme.colorScheme.onErrorContainer,
          duration: Duration(seconds: 5),
          margin: EdgeInsets.all(16),
          borderRadius: 12,
          icon: Icon(
            Icons.warning_amber_rounded,
            color: Get.theme.colorScheme.error,
          ),
        );
        Get.offNamed(AppRoutes.home);
        return;
      }
    }
    
    if (returnRoute != null) {
      Get.offNamed(returnRoute);
    } else {
      // Default navigation after login
      Get.offNamed(AppRoutes.mailbox);
    }
  }

  void navigateToHome() {
    Get.offNamed(AppRoutes.home);
  }

  void navigateToCreate() {
    Get.toNamed(AppRoutes.create);
  }
}