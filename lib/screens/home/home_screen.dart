import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mailstr/app_routes.dart';
import 'package:mailstr/config.dart';
import 'package:mailstr/l10n/app_localizations.dart';
import 'package:mailstr/widgets/content_padding_view.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, kToolbarHeight),
        child: ContentPaddingView(
          child: AppBar(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            title: Text(appTitle),
            titleSpacing: 8,
            actions: [
              IconButton(
                onPressed: () async {
                  final Uri url = Uri.parse(
                    'https://njump.me/npub1kg4sdvz3l4fr99n2jdz2vdxe2mpacva87hkdetv76ywacsfq5leqquw5te',
                  );
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  }
                },
                icon: SvgPicture.asset(
                  'assets/nostr_icon.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.onSurface,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              SizedBox(width: 8),
              IconButton(
                onPressed: () async {
                  final Uri url = Uri.parse('https://github.com/nogringo/mailstr');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  }
                },
                icon: SvgPicture.asset(
                  'assets/github_icon.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.onSurface,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              SizedBox(width: 8),
              FilledButton(
                onPressed: () => Get.toNamed(AppRoutes.create),
                child: Text(AppLocalizations.of(context)!.create),
              ),
              SizedBox(width: 8),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 4, right: 8, left: 8, bottom: 100),
        child: ContentPaddingView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 32),

              // Hero Section
              Text(
                AppLocalizations.of(context)!.nostrBasedEmailService,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),

              Text(
                AppLocalizations.of(context)!.createSecureEmailAddresses,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 48),

              // Why It's Better Section
              Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.outline.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.whyAppTitle(appTitle),
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.whyAppTitleDescription(appTitle),
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(height: 1.6),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 48),
              Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.outline.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.howCanITrustYou,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.trustDescription(appTitle),
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(height: 1.6),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 48),

              // Simple Features
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSimpleFeature(
                    context,
                    Icons.no_accounts,
                    AppLocalizations.of(context)!.noAccounts,
                  ),
                  _buildSimpleFeature(context, Icons.visibility_off, AppLocalizations.of(context)!.noLogs),
                  _buildSimpleFeature(context, Icons.gpp_good, AppLocalizations.of(context)!.justPrivacy),
                ],
              ),
              SizedBox(height: 48),

              // CTA
              Column(
                children: [
                  FilledButton(
                    onPressed: () => Get.toNamed(AppRoutes.create),
                    style: FilledButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.createEmailAddressNow,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!.takesLessThan30Seconds,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 64),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      final Uri url = Uri.parse(
                        'https://github.com/nogringo/mailstr',
                      );
                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                    icon: SvgPicture.asset(
                      'assets/github_icon.svg',
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  IconButton(
                    onPressed: () async {
                      final Uri url = Uri.parse(
                        'https://njump.me/npub1kg4sdvz3l4fr99n2jdz2vdxe2mpacva87hkdetv76ywacsfq5leqquw5te',
                      );
                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                    icon: SvgPicture.asset(
                      'assets/nostr_icon.svg',
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.primary,
                        BlendMode.srcIn,
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

  Widget _buildSimpleFeature(
    BuildContext context,
    IconData icon,
    String title,
  ) {
    return Column(
      children: [
        Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
        SizedBox(height: 8),
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
