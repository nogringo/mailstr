import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailstr/app_routes.dart';
import 'package:mailstr/widgets/content_padding_view.dart';
import 'package:mailstr/widgets/user_avatar.dart';
import 'package:mailstr/config.dart';
import 'package:mailstr/screens/nip05/nip05_controller.dart';
import 'package:mailstr/l10n/app_localizations.dart';

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
            title: Text(AppLocalizations.of(context)!.createYourAddress),
            titleSpacing: 8,
            actions: [
              TextButton(
                onPressed: () => Get.toNamed(AppRoutes.home),
                child: Text(AppLocalizations.of(context)!.home),
              ),
              SizedBox(width: 8),
              // User profile picture (always shown since this screen requires login)
              Container(
                margin: EdgeInsets.only(right: 8),
                child: UserAvatar(radius: 16),
              ),
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
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.nameController,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.username,
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

                  // Private toggle
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        Icon(
                          Icons.lock_outline,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.6),
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppLocalizations.of(context)!.private, style: TextStyle(fontSize: 14)),
                              Text(
                                AppLocalizations.of(context)!.hideFromPublicDirectory,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSurface
                                      .withValues(alpha: 0.6),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Obx(
                          () => Switch(
                            value: controller.isPrivate.value,
                            onChanged: (value) =>
                                controller.isPrivate.value = value,
                          ),
                        ),
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
                                AppLocalizations.of(context)!.register,
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
            ],
          ),
        ),
      ),
    );
  }
}
