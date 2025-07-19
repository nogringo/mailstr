import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailstr/app_routes.dart';
import 'package:mailstr/controllers/auth_controller.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    final authController = Get.find<AuthController>();
    
    // If user is not logged in, redirect to login with return route
    if (!authController.isLoggedIn) {
      return RouteSettings(
        name: AppRoutes.login,
        arguments: {'returnRoute': route},
      );
    }
    
    // User is logged in, allow access
    return null;
  }
}