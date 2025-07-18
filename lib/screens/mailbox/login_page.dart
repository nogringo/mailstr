import 'package:flutter/material.dart';
import 'package:mailstr/controllers/auth_controller.dart';
import 'package:mailstr/widgets/content_padding_view.dart';
import 'package:ndk_ui/widgets/n_login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, kToolbarHeight),
        child: ContentPaddingView(
          maxWidth: 500,
          child: AppBar(title: Text("Mailbox Login")),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 4, right: 8, left: 8, bottom: 100),
        child: ContentPaddingView(
          maxWidth: 500,
          child: NLogin(
            ndk: AuthController.to.ndk,
            onLoggedIn: AuthController.to.update,
            enableNip05Login: false,
            enableNpubLogin: false,
          ),
        ),
      ),
    );
  }
}
