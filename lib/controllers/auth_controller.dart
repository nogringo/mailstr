import 'package:get/get.dart';
import 'package:ndk/ndk.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();
  
  Ndk get ndk => Get.find<Ndk>();
  
  bool get isLoggedIn => ndk.accounts.isLoggedIn;
}