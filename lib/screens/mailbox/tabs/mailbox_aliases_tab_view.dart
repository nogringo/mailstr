import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:mailstr/l10n/app_localizations.dart';
import 'package:mailstr/screens/mailbox/mailbox_controller.dart';
import 'package:ndk/ndk.dart';
import 'package:nip19/nip19.dart';
import 'package:mailstr/app_routes.dart';
import 'package:mailstr/hex_to_base_36.dart';
import 'package:mailstr/config.dart';

class MailboxAliasesTabView extends StatelessWidget {
  const MailboxAliasesTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MailboxController.to;
    final ndk = Get.find<Ndk>();
    
    
    return Obx(() {
      final canSign = ndk.accounts.canSign;
      
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
                AppLocalizations.of(context)!.noAliasesYet,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.tapPlusToCreateAlias,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        );
      }
      
      return Column(
        children: [
          // Show warning when user can't sign
          if (!canSign) ...[
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.limitedView,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          AppLocalizations.of(context)!.youCanOnlySeeDefaultAliases,
                          style: TextStyle(
                            fontSize: 13,
                            color: Theme.of(context).colorScheme.primary,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  FilledButton.icon(
                    onPressed: () => Get.toNamed(AppRoutes.login, arguments: {'returnRoute': AppRoutes.mailbox}),
                    icon: Icon(Icons.login, size: 16),
                    label: Text(AppLocalizations.of(context)!.login),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      textStyle: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
          // Show aliases list
          Expanded(
            child: ListView.builder(
              itemCount: controller.aliases.length,
              itemBuilder: (context, index) {
                final alias = controller.aliases[index];
                final parts = alias.split('@');
                final name = parts.isNotEmpty ? parts[0] : '';
                
                // Check if this is a standard alias (npub, hex pubkey, or base36)
                final isStandardAlias = _isStandardAlias(alias);
                
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
                                  AppLocalizations.of(context)!.tapToCopy,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (!isStandardAlias && canSign) ...[
                            IconButton(
                              icon: Icon(
                                Icons.delete_outline,
                                size: 20,
                                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                              ),
                              onPressed: () => _showUnregisterDialog(context, name),
                            ),
                          ] else ...[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.copy,
                                size: 20,
                                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }

  bool _isStandardAlias(String alias) {
    final ndk = Get.find<Ndk>();
    final pubkey = ndk.accounts.getPublicKey();
    
    if (pubkey == null) return false;
    
    try {
      final npub = Nip19.npubFromHex(pubkey);
      final base36 = hexToBase36(pubkey);
      
      // Check if it's one of the standard aliases
      return alias.startsWith('$npub@') ||
             alias.startsWith('$pubkey@') ||
             alias.startsWith('$base36@');
    } catch (e) {
      return false;
    }
  }

  void _showUnregisterDialog(BuildContext context, String name) {
    final fullAddress = '$name@$emailDomain';
    Get.dialog(
      AlertDialog(
        title: Text(AppLocalizations.of(context)!.unregisterAlias),
        content: RichText(
          text: TextSpan(
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            children: [
              TextSpan(text: '${AppLocalizations.of(context)!.areYouSureUnregister} '),
              TextSpan(
                text: fullAddress,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(text: '?'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          FilledButton(
            onPressed: () async {
              Get.back(); // Close dialog
              
              // Show loading
              Get.dialog(
                Center(child: CircularProgressIndicator()),
                barrierDismissible: false,
              );
              
              final success = await MailboxController.to.unregisterNip05(name);
              
              Get.back(); // Close loading
              
              if (success) {
                toastification.show(
                  title: Text(AppLocalizations.of(Get.context!)!.aliasUnregistered),
                  alignment: Alignment.bottomRight,
                  style: ToastificationStyle.fillColored,
                  icon: Icon(Icons.check_circle),
                  applyBlurEffect: true,
                  primaryColor: Get.theme.colorScheme.primary,
                  backgroundColor: Get.theme.colorScheme.onPrimary,
                  autoCloseDuration: Duration(seconds: 3),
                  closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
                );
              } else {
                toastification.show(
                  title: Text(AppLocalizations.of(Get.context!)!.error),
                  description: Text(AppLocalizations.of(Get.context!)!.failedToUnregisterAlias),
                  alignment: Alignment.bottomRight,
                  style: ToastificationStyle.fillColored,
                  icon: Icon(Icons.error),
                  applyBlurEffect: true,
                  primaryColor: Get.theme.colorScheme.error,
                  backgroundColor: Get.theme.colorScheme.onError,
                  autoCloseDuration: Duration(seconds: 4),
                  closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
                );
              }
            },
            child: Text(AppLocalizations.of(context)!.unregister),
          ),
        ],
      ),
    );
  }
}