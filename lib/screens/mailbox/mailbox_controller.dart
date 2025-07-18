import 'package:get/get.dart';

class MailboxController extends GetxController {
  static MailboxController get to => Get.find();

  RxInt selectedIndex = 0.obs;
}