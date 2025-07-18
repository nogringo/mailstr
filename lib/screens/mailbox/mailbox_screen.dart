import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailstr/screens/mailbox/layouts/mailbox_large_layout.dart';
import 'package:mailstr/screens/mailbox/layouts/mailbox_small_layout.dart';
import 'package:mailstr/screens/mailbox/login_page.dart';
import 'package:mailstr/controllers/auth_controller.dart';

class MailboxScreen extends StatelessWidget {
  const MailboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (authController) {
        if (authController.isLoggedIn) {
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
