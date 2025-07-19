import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:mailstr/l10n/app_localizations.dart';
import 'package:mailstr/screens/mailbox/mailbox_controller.dart';

class MailboxAliasesTabView extends StatelessWidget {
  const MailboxAliasesTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MailboxController.to;
    
    return Obx(() {
      if (controller.aliases.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.alternate_email,
                size: 64,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
              ),
              const SizedBox(height: 16),
              Text(
                'No aliases yet',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Tap + to create your first alias',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        );
      }
      
      return ListView.builder(
        itemCount: controller.aliases.length,
        itemBuilder: (context, index) {
          final alias = controller.aliases[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Clipboard.setData(ClipboardData(text: alias));
                toastification.show(
                  title: Text(AppLocalizations.of(Get.context!)!.copied),
                  alignment: Alignment.bottomRight,
                  style: ToastificationStyle.fillColored,
                  icon: Icon(Icons.copy),
                  applyBlurEffect: true,
                  primaryColor: Get.theme.colorScheme.primaryContainer,
                  backgroundColor: Get.theme.colorScheme.onPrimaryContainer,
                  autoCloseDuration: Duration(seconds: 3),
                  closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.alternate_email,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            alias,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Tap to copy',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.copy,
                      size: 20,
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}