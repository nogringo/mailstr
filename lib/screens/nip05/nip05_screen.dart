import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailstr/app_routes.dart';
import 'package:mailstr/widgets/content_padding_view.dart';
import 'package:ndk/ndk.dart';
import 'package:mailstr/config.dart';
import 'package:mailstr/controllers/auth_controller.dart';
import 'package:mailstr/screens/nip05/nip05_controller.dart';
import 'package:ndk_ui/ndk_ui.dart';
import 'package:ndk_ui/widgets/n_login.dart';

class Nip05Screen extends StatelessWidget {
  const Nip05Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Nip05Controller());

    return Scaffold(
      backgroundColor: const Color(0xFF1a1a1a),
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, kToolbarHeight),
        child: ContentPaddingView(
          maxWidth: 400,
          child: AppBar(
            title: Text("Create your address"),
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
        padding: const EdgeInsets.all(24.0),
        child: ContentPaddingView(
          maxWidth: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  // Username field with domain
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF3a3a3a),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Color(0xFF505050)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.nameController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'username',
                              hintStyle: TextStyle(color: Colors.white38),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(16),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          child: Text(
                            '@$emailDomain',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                    
                  // Pubkey field or login button
                  GetBuilder<AuthController>(
                    builder: (authController) {
                      if (!authController.isLoggedIn) {
                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF3a3a3a),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Color(0xFF505050)),
                              ),
                              child: TextField(
                                controller: controller.pubkeyController,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'Public key (hex or npub)',
                                  hintStyle: TextStyle(color: Colors.white38),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(16),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'OR',
                              style: TextStyle(color: Colors.white54, fontSize: 12),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  // Show login dialog
                                  showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                      backgroundColor: Color(0xFF2a2a2a),
                                      child: Container(
                                        padding: EdgeInsets.all(24),
                                        constraints: BoxConstraints(maxWidth: 400),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Login with Nostr',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.close, color: Colors.white54),
                                                  onPressed: () => Navigator.of(context).pop(),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 16),
                                            NLogin(
                                              ndk: Get.find<Ndk>(),
                                              onLoggedIn: () {
                                                // Update pubkey field after login
                                                final pubkey = controller.ndk.accounts.getPublicKey();
                                                if (pubkey != null) {
                                                  controller.pubkeyController.text = pubkey;
                                                }
                                                // Update auth state
                                                Get.find<AuthController>().update();
                                                // Close dialog
                                                Navigator.of(context).pop();
                                              },
                                              enableNip05Login: false,
                                              enableNpubLogin: false,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Theme.of(context).colorScheme.primary,
                                  side: BorderSide(color: Theme.of(context).colorScheme.primary),
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                icon: Icon(Icons.login),
                                label: Text('Login with Nostr'),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Color(0xFF3a3a3a),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5)),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: Theme.of(context).colorScheme.primary,
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Logged in',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      controller.pubkeyController.text.length > 20 
                                          ? '${controller.pubkeyController.text.substring(0, 8)}...${controller.pubkeyController.text.substring(controller.pubkeyController.text.length - 8)}'
                                          : controller.pubkeyController.text,
                                      style: TextStyle(
                                        color: Colors.white54,
                                        fontSize: 12,
                                        fontFamily: 'monospace',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                    
                  // Private toggle
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        Icon(Icons.lock_outline, color: Colors.white54, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Private',
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              ),
                              Text(
                                'Hide from public directory',
                                style: TextStyle(color: Colors.white54, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Obx(() => Switch(
                          value: controller.isPrivate.value,
                          onChanged: (value) => controller.isPrivate.value = value,
                        )),
                      ],
                    ),
                  ),
                    
                  const SizedBox(height: 24),
                    
                  // Register button
                  SizedBox(
                    width: double.infinity,
                    child: Obx(
                      () => FilledButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : controller.registerNip05,
                        child: controller.isLoading.value
                            ? SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),
                              )
                            : Text(
                                'REGISTER',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              // const SizedBox(height: 24),
      
              // // Registered users counter
              // Container(
              //   width: double.infinity,
              //   padding: const EdgeInsets.all(16),
              //   decoration: BoxDecoration(
              //     color: Color(0xFF2a2a2a),
              //     borderRadius: BorderRadius.circular(8),
              //     border: Border.all(color: Color(0xFF404040)),
              //   ),
              //   child: Text(
              //     'Registered users: 860 🔥',
              //     style: TextStyle(
              //       color: Theme.of(context).colorScheme.primary,
              //       fontSize: 14,
              //       fontWeight: FontWeight.w500,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
