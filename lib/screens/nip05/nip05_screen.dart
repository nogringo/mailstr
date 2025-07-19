import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailstr/app_routes.dart';
import 'package:mailstr/widgets/content_padding_view.dart';
import 'package:mailstr/widgets/user_avatar.dart';
import 'package:mailstr/config.dart';
import 'package:mailstr/screens/nip05/nip05_controller.dart';

class Nip05Screen extends StatelessWidget {
  const Nip05Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Nip05Controller());

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, kToolbarHeight),
        child: ContentPaddingView(
          maxWidth: 400,
          child: AppBar(
            title: Text("Create your address"),
            titleSpacing: 8,
            actions: [
              // User profile picture (always shown since this screen requires login)
              Container(
                margin: EdgeInsets.only(right: 8),
                child: UserAvatar(radius: 16),
              ),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  // Username field with domain
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Theme.of(context).colorScheme.outline),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.nameController,
                            decoration: InputDecoration(
                              hintText: 'username',
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
                    
                  // User info (always logged in due to middleware)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
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
                                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                                  fontSize: 12,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                    
                  // Private toggle
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        Icon(
                          Icons.lock_outline, 
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6), 
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Private',
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                'Hide from public directory',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6), 
                                  fontSize: 12,
                                ),
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
