import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailstr/app_routes.dart';
import 'package:mailstr/screens/mailbox/mailbox_controller.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk_ui/functions/n_logout.dart';

class LogoutButtonView extends StatelessWidget {
  const LogoutButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        // Clear messages and cancel subscription
        if (Get.isRegistered<MailboxController>()) {
          final controller = MailboxController.to;
          controller.messages.clear();
          controller.cancelMessagesSubscription();
        }
        
        await nLogout(Get.find<Ndk>());
        Get.offAllNamed(AppRoutes.home);
      },
      icon: Icon(Icons.logout),
    );
  }
}
