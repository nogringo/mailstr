import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailstr/app_routes.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk_ui/widgets/n_login.dart';
import 'package:mailstr/screens/login/login_controller.dart';
import 'package:mailstr/widgets/content_padding_view.dart';
import 'package:mailstr/controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Obx(() {
      final authController = Get.find<AuthController>();
      
      // If already logged in, redirect to mailbox
      if (authController.isLoggedIn) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.offNamed(AppRoutes.mailbox);
        });
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, kToolbarHeight),
        child: ContentPaddingView(
          maxWidth: 400,
          child: AppBar(
            title: Text("Mailstr Login"),
            titleSpacing: 8,
            actions: [
              TextButton(
                onPressed: () => Get.toNamed(AppRoutes.home),
                child: Text('Home'),
              ),
              SizedBox(width: 8),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 4, right: 8, left: 8, bottom: 100),
        child: ContentPaddingView(
          maxWidth: 400,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.vpn_key_rounded,
                  size: 32,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Connect with Nostr',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Secure, decentralized authentication',
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Enhanced Login widget
              NLogin(
                ndk: Get.find<Ndk>(),
                onLoggedIn: controller.onLoginSuccess,
              ),
            ],
          ),
        ),
      ),
    );
    });
  }
}
