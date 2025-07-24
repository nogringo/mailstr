import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailstr/app_routes.dart';
import 'package:mailstr/controllers/auth_controller.dart';

class GuestMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    final authController = Get.find<AuthController>();
    
    // If user is logged in, redirect to mailbox
    if (authController.isLoggedIn) {
      return RouteSettings(
        name: AppRoutes.mailbox,
      );
    }
    
    // User is not logged in, allow access to guest pages
    return null;
  }
}