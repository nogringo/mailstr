import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ndk_ui/ndk_ui.dart';
import 'package:mailstr/controllers/auth_controller.dart';

class MailboxScreen extends StatelessWidget {
  const MailboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<AuthController>(
        builder: (authController) {
          return authController.isLoggedIn
              ? ListView(children: [])
              : NLogin(
                  ndk: authController.ndk,
                  onLoggedIn: authController.update,
                );
        },
      ),
    );
  }
}
