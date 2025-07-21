import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailstr/screens/mailbox/layouts/mailbox_large_layout.dart';
import 'package:mailstr/screens/mailbox/layouts/mailbox_small_layout.dart';
import 'package:mailstr/controllers/auth_controller.dart';
import 'package:mailstr/screens/mailbox/mailbox_controller.dart';
import 'package:mailstr/app_routes.dart';

class MailboxScreen extends StatefulWidget {
  const MailboxScreen({super.key});

  @override
  State<MailboxScreen> createState() => _MailboxScreenState();
}

class _MailboxScreenState extends State<MailboxScreen> {
  @override
  void initState() {
    super.initState();
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
          return LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return MailboxLargeLayout();
              }
              return MailboxSmallLayout();
            },
          );
        }

        // If not logged in, redirect to login screen
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.offNamed(AppRoutes.login, arguments: {'returnRoute': AppRoutes.mailbox});
        });
        
        // Show loading while redirecting
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
