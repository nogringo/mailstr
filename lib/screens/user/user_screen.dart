import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailstr/app_routes.dart';
import 'package:mailstr/widgets/content_padding_view.dart';
import 'package:mailstr/widgets/user_avatar.dart';
import 'package:mailstr/screens/user/user_controller.dart';
import 'package:mailstr/controllers/auth_controller.dart';
import 'package:mailstr/controllers/theme_controller.dart';
import 'package:ndk/ndk.dart';
import 'package:mailstr/l10n/app_localizations.dart';
import 'package:nostr_widgets/nostr_widgets.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, kToolbarHeight),
        child: ContentPaddingView(
          maxWidth: 600,
          child: AppBar(
            actions: [
              TextButton(
                onPressed: () => Get.toNamed(AppRoutes.home),
                child: Text(AppLocalizations.of(context)!.home),
              ),
            ],
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.loadingProfile,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.only(top: 4, right: 8, left: 8, bottom: 100),
          child: ContentPaddingView(
            maxWidth: 600,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Banner section with overlapping avatar
                if (controller.pubkey.value.isNotEmpty)
                  Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 60,
                        ), // Half avatar height
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: AspectRatio(
                            aspectRatio: 3 / 1,
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: NBanner(
                                ndk: controller.ndk,
                                pubkey: controller.pubkey.value,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Profile picture positioned 50% on banner
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.surface,
                                  width: 4,
                                ),
                              ),
                              child: UserAvatar(
                                radius: 60,
                                clickable: false,
                                pubkey: controller.pubkey.value,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                // Content section
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: ContentPaddingView(
                    maxWidth: 600,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Display name and about section
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            children: [
                              // Display name with copy button
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (controller.ndk.accounts.getPublicKey() != null)
                                    Flexible(
                                      child: NName(
                                        ndk: controller.ndk,
                                        pubkey: controller.ndk.accounts.getPublicKey()!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                            ),
                                      ),
                                    ),
                                  if (controller.ndk.accounts.getPublicKey() != null)
                                    const SizedBox(width: 8),
                                  if (controller.ndk.accounts.getPublicKey() != null)
                                    IconButton(
                                      onPressed: () => controller.copyToClipboard(
                                        controller.npub.value,
                                      'Npub',
                                    ),
                                    icon: Icon(
                                      Icons.copy,
                                      size: 20,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                                    style: IconButton.styleFrom(
                                      minimumSize: Size(32, 32),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Account actions
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Simple action buttons
                                _buildSimpleActionButton(
                                  context,
                                  AppLocalizations.of(context)!.goToMailbox,
                                  Icons.email,
                                  () => Get.toNamed(AppRoutes.mailbox),
                                ),
                                const SizedBox(height: 12),

                                _buildLogoutButton(context),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Theme settings
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.appearance,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface,
                                      ),
                                ),
                                const SizedBox(height: 16),

                                // Theme mode selection
                                _buildThemeModeSelector(context),
                                const SizedBox(height: 16),

                                // Accent color selection
                                _buildAccentColorSelector(context),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 48),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSimpleActionButton(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return InkWell(
      onTap: () {
        // Show confirmation dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context)!.logout),
              content: Text(AppLocalizations.of(context)!.logoutConfirmation),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(AppLocalizations.of(context)!.cancel),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    // Perform logout
                    Get.find<Ndk>().accounts.logout();
                    nSaveAccountsState(Get.find<Ndk>());

                    // Reset theme colors to default
                    Get.find<ThemeController>().resetToDefaultColors();

                    // Update auth controller state
                    Get.find<AuthController>().updateAuthState();

                    Get.offAllNamed(AppRoutes.home);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.logout,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(
              Icons.logout,
              size: 20,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                AppLocalizations.of(context)!.logout,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Theme.of(context).colorScheme.error.withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeModeSelector(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.themeMode,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildThemeOption(
                  context,
                  ThemeMode.light,
                  AppLocalizations.of(context)!.light,
                  Icons.light_mode,
                ),
                const SizedBox(width: 8),
                _buildThemeOption(
                  context,
                  ThemeMode.dark,
                  AppLocalizations.of(context)!.dark,
                  Icons.dark_mode,
                ),
                const SizedBox(width: 8),
                _buildThemeOption(
                  context,
                  ThemeMode.system,
                  AppLocalizations.of(context)!.system,
                  Icons.brightness_auto,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    ThemeMode mode,
    String label,
    IconData icon,
  ) {
    final themeController = Get.find<ThemeController>();
    final isSelected = themeController.themeMode == mode;

    return Expanded(
      child: InkWell(
        onTap: () => themeController.setThemeMode(mode),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).colorScheme.primaryContainer
                : Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(
                      context,
                    ).colorScheme.outline.withValues(alpha: 0.3),
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 24,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccentColorSelector(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.accentColor,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildAccentOption(
                  context,
                  AccentColorType.defaultColor,
                  AppLocalizations.of(context)!.defaultColor,
                  Icons.palette,
                ),
                const SizedBox(width: 8),
                _buildAccentOption(
                  context,
                  AccentColorType.pictureColor,
                  AppLocalizations.of(context)!.picture,
                  Icons.account_circle,
                ),
                const SizedBox(width: 8),
                _buildAccentOption(
                  context,
                  AccentColorType.bannerColor,
                  AppLocalizations.of(context)!.banner,
                  Icons.image,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildAccentOption(
    BuildContext context,
    AccentColorType type,
    String label,
    IconData icon,
  ) {
    final themeController = Get.find<ThemeController>();
    final userController = Get.find<UserController>();
    final isSelected = themeController.accentColorType == type;

    return Expanded(
      child: InkWell(
        onTap: () async {
          themeController.setAccentColorType(type);

          // Extract color from appropriate image
          if (type == AccentColorType.pictureColor &&
              userController.pubkey.value.isNotEmpty) {
            try {
              final metadata = await userController.ndk.metadata.loadMetadata(
                userController.pubkey.value,
              );
              if (metadata?.picture != null && metadata!.picture!.isNotEmpty) {
                final imageProvider = NetworkImage(metadata.picture!);
                await themeController.extractColorFromPicture(imageProvider);
              }
            } catch (e) {
              // Error loading picture metadata
            }
          } else if (type == AccentColorType.bannerColor &&
              userController.pubkey.value.isNotEmpty) {
            try {
              final metadata = await userController.ndk.metadata.loadMetadata(
                userController.pubkey.value,
              );
              if (metadata?.banner != null && metadata!.banner!.isNotEmpty) {
                final imageProvider = NetworkImage(metadata.banner!);
                await themeController.extractColorFromBanner(imageProvider);
              }
            } catch (e) {
              // Error loading banner metadata
            }
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).colorScheme.primaryContainer
                : Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(
                      context,
                    ).colorScheme.outline.withValues(alpha: 0.3),
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 24,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
