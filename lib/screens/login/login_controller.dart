import 'package:get/get.dart';
import 'package:mailstr/app_routes.dart';
import 'package:mailstr/controllers/auth_controller.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();

  void onLoginSuccess() {
    // Update auth state
    Get.find<AuthController>().update();
    
    // Check if we have a return route
    final dynamic args = Get.arguments;
    if (args != null && args['returnRoute'] != null) {
      Get.offNamed(args['returnRoute']);
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