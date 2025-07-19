import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailstr/screens/mailbox/layouts/mailbox_large_layout.dart';
import 'package:mailstr/screens/mailbox/layouts/mailbox_small_layout.dart';
import 'package:mailstr/screens/mailbox/login_page.dart';
import 'package:mailstr/controllers/auth_controller.dart';
import 'package:mailstr/screens/mailbox/mailbox_controller.dart';

class MailboxScreen extends StatefulWidget {
  const MailboxScreen({super.key});

  @override
  State<MailboxScreen> createState() => _MailboxScreenState();
}

class _MailboxScreenState extends State<MailboxScreen> {
  @override
  void initState() {
    super.initState();
    // Start listening for messages if already logged in
    if (Get.find<AuthController>().isLoggedIn) {
      MailboxController.to.listenMessages();
    }
  }

  @override
  void dispose() {
    MailboxController.to.cancelMessagesSubscription();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (authController) {
        if (authController.isLoggedIn) {
          // Start listening when user logs in
          MailboxController.to.listenMessages();
          
          return LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return MailboxLargeLayout();
              }
              return MailboxSmallLayout();
            },
          );
        }

        return LoginPage();
      },
    );
  }
}
