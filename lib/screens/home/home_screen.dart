import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mailstr/app_routes.dart';
import 'package:mailstr/config.dart';
import 'package:mailstr/controllers/theme_controller.dart';
import 'package:mailstr/l10n/app_localizations.dart';
import 'package:mailstr/widgets/content_padding_view.dart';
import 'package:nip19/nip19.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, kToolbarHeight),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ContentPaddingView(
              child: AppBar(
                title: Text(appTitle),
                titleSpacing: 8,
                actions: [
                  if (constraints.maxWidth > 600) ...[
                    IconButton(
                      onPressed: () async {
                        final Uri url = Uri.parse(
                          'https://njump.me/${Nip19.npubFromHex(serverPubkey)}',
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
                          Theme.of(context).colorScheme.onSurface,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
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
                          Theme.of(context).colorScheme.onSurface,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    GetBuilder<ThemeController>(
                      builder: (themeController) {
                        return IconButton(
                          onPressed: themeController.toggleTheme,
                          icon: Icon(themeController.themeIcon),
                          tooltip:
                              '${AppLocalizations.of(context)!.switchTo} ${themeController.themeModeString} ${AppLocalizations.of(context)!.theme}',
                        );
                      },
                    ),
                    SizedBox(width: 8),
                  ],
                  FilledButton(
                    onPressed: () => Get.toNamed(AppRoutes.mailbox),
                    child: Text(AppLocalizations.of(context)!.mailbox),
                  ),
                  SizedBox(width: 8),
                  // Obx(() {
                  //   final authController = Get.find<AuthController>();
                  //   if (!authController.isLoggedIn) {
                  //     return Container();
                  //   } else {
                  //     // Show user profile picture when logged in
                  //     return Row(
                  //       children: [
                  //         Container(
                  //           margin: EdgeInsets.only(right: 8),
                  //           child: UserAvatar(radius: 16),
                  //         ),
                  //       ],
                  //     );
                  //   }
                  // }),
                ],
              ),
            );
          },
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
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  children: _buildTextWithNostrLink(
                    context,
                    AppLocalizations.of(context)!.nostrBasedEmailService,
                  ),
                ),
              ),
              // SizedBox(height: 16),

              // RichText(
              //   textAlign: TextAlign.center,
              //   text: TextSpan(
              //     style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              //       color: Theme.of(
              //         context,
              //       ).colorScheme.onSurface.withValues(alpha: 0.7),
              //     ),
              //     children: _buildTextWithNostrLink(
              //       context,
              //       AppLocalizations.of(context)!.createSecureEmailAddresses,
              //     ),
              //   ),
              // ),
              SizedBox(height: 48),

              Container(
                decoration: BoxDecoration(
                  // color: Theme.of(
                  //   context,
                  // ).colorScheme.primaryContainer.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.outline.withValues(alpha: 0.3),
                  ),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.verified,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text(AppLocalizations.of(context)!.claimYourNip05),
                  trailing: TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.nip05);
                    },
                    child: Text(AppLocalizations.of(context)!.claim),
                  ),
                ),
              ),
              // SizedBox(height: 48),

              // // Why It's Better Section
              // Container(
              //   padding: EdgeInsets.all(24),
              //   decoration: BoxDecoration(
              //     color: Theme.of(context).colorScheme.surface,
              //     borderRadius: BorderRadius.circular(12),
              //     border: Border.all(
              //       color: Theme.of(
              //         context,
              //       ).colorScheme.outline.withValues(alpha: 0.3),
              //     ),
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         AppLocalizations.of(context)!.whyAppTitle(appTitle),
              //         style: Theme.of(context).textTheme.headlineSmall
              //             ?.copyWith(fontWeight: FontWeight.bold),
              //       ),
              //       SizedBox(height: 16),
              //       RichText(
              //         text: TextSpan(
              //           style: Theme.of(
              //             context,
              //           ).textTheme.bodyMedium?.copyWith(height: 1.6),
              //           children: _buildTextWithNostrLink(
              //             context,
              //             AppLocalizations.of(
              //               context,
              //             )!.whyAppTitleDescription(appTitle),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
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
                      AppLocalizations.of(context)!.whyChooseMailstr(appTitle),
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.whyChooseMailstrDescription,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(height: 1.6),
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 48),
              // Container(
              //   padding: EdgeInsets.all(24),
              //   decoration: BoxDecoration(
              //     color: Theme.of(context).colorScheme.surface,
              //     borderRadius: BorderRadius.circular(12),
              //     border: Border.all(
              //       color: Theme.of(
              //         context,
              //       ).colorScheme.outline.withValues(alpha: 0.3),
              //     ),
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         AppLocalizations.of(context)!.whereToReadEmails,
              //         style: Theme.of(context).textTheme.headlineSmall
              //             ?.copyWith(fontWeight: FontWeight.bold),
              //       ),
              //       SizedBox(height: 16),
              //       RichText(
              //         text: TextSpan(
              //           style: Theme.of(
              //             context,
              //           ).textTheme.bodyMedium?.copyWith(height: 1.6),
              //           children: _buildTextWithNostrLink(
              //             context,
              //             AppLocalizations.of(context)!.whereToReadEmailsDescription,
              //           ),
              //         ),
              //       ),
              //       SizedBox(height: 16),
              //       Wrap(
              //         spacing: 8,
              //         runSpacing: 8,
              //         children: [
              //           OutlinedButton.icon(
              //             onPressed: () async {
              //               final Uri url = Uri.parse('https://yakihonne.com');
              //               if (await canLaunchUrl(url)) {
              //                 await launchUrl(url, mode: LaunchMode.externalApplication);
              //               }
              //             },
              //             label: Text('Yakihonne'),  // This is a proper name, no translation needed
              //             icon: Icon(Icons.language),
              //           ),
              //           OutlinedButton.icon(
              //             onPressed: () async {
              //               final Uri url = Uri.parse('https://0xchat.com');
              //               if (await canLaunchUrl(url)) {
              //                 await launchUrl(url, mode: LaunchMode.externalApplication);
              //               }
              //             },
              //             label: Text('0xchat'),  // This is a proper name, no translation needed
              //             icon: Icon(Icons.phone_android_outlined),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(height: 48),
              // Container(
              //   padding: EdgeInsets.all(24),
              //   decoration: BoxDecoration(
              //     color: Theme.of(context).colorScheme.surface,
              //     borderRadius: BorderRadius.circular(12),
              //     border: Border.all(
              //       color: Theme.of(
              //         context,
              //       ).colorScheme.outline.withValues(alpha: 0.3),
              //     ),
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       RichText(
              //         text: TextSpan(
              //           style: Theme.of(context).textTheme.headlineSmall
              //               ?.copyWith(fontWeight: FontWeight.bold),
              //           children: _buildTextWithNostrLink(
              //             context,
              //             AppLocalizations.of(context)!.alreadyHaveNostrAccount,
              //           ),
              //         ),
              //       ),
              //       SizedBox(height: 16),
              //       RichText(
              //         text: TextSpan(
              //           style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.6),
              //           children: _buildYesAnswerSpans(context),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(height: 48),

              // Features Carousel
              _FeaturesCarousel(),
              SizedBox(height: 48),

              // // CTA
              // Column(
              //   children: [
              //     FilledButton(
              //       onPressed: () => Get.toNamed(AppRoutes.create),
              //       style: FilledButton.styleFrom(
              //         padding: EdgeInsets.symmetric(
              //           horizontal: 32,
              //           vertical: 16,
              //         ),
              //       ),
              //       child: Text(
              //         AppLocalizations.of(context)!.createEmailAddressNow,
              //         style: TextStyle(fontSize: 16),
              //       ),
              //     ),
              //     SizedBox(height: 16),
              //     Text(
              //       AppLocalizations.of(context)!.takesLessThan30Seconds,
              //       style: Theme.of(context).textTheme.bodySmall?.copyWith(
              //         color: Theme.of(
              //           context,
              //         ).colorScheme.onSurface.withValues(alpha: 0.6),
              //       ),
              //     ),
              //   ],
              // ),
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
                        'https://njump.me/${Nip19.npubFromHex(serverPubkey)}',
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

  List<TextSpan> _buildTextWithNostrLink(BuildContext context, String text) {
    final spans = <TextSpan>[];
    final nostrRegExp = RegExp(r'Nostr', caseSensitive: false);
    int lastMatchEnd = 0;

    for (final match in nostrRegExp.allMatches(text)) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(text: text.substring(lastMatchEnd, match.start)));
      }

      spans.add(
        TextSpan(
          text: text.substring(match.start, match.end),
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              final Uri url = Uri.parse('https://nstart.me/');
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              }
            },
        ),
      );

      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastMatchEnd)));
    }

    return spans;
  }
}

class _FeaturesCarousel extends StatefulWidget {
  @override
  _FeaturesCarouselState createState() => _FeaturesCarouselState();
}

class _FeaturesCarouselState extends State<_FeaturesCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<_Feature> _getFeatures(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      _Feature(
        icon: Icons.free_breakfast,
        title: l10n.free,
        description: l10n.freeDescription,
      ),
      _Feature(
        icon: Icons.no_accounts,
        title: l10n.noSubscription,
        description: l10n.noSubscriptionDescription,
      ),
      _Feature(
        icon: Icons.visibility_off,
        title: l10n.noLogsFeature,
        description: l10n.noLogsDescription,
      ),
      _Feature(
        icon: Icons.all_inclusive,
        title: l10n.unlimitedAccounts,
        description: l10n.unlimitedAccountsDescription,
      ),
      _Feature(
        icon: Icons.hub,
        title: l10n.nostrBased,
        description: l10n.nostrBasedDescription,
      ),
      _Feature(
        icon: Icons.person_off,
        title: l10n.anonymous,
        description: l10n.anonymousDescription,
      ),
      _Feature(
        icon: Icons.code,
        title: l10n.openSourceClient,
        description: l10n.openSourceClientDescription,
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    // Auto-scroll every 5 seconds
    Timer.periodic(Duration(seconds: 5), (timer) {
      if (mounted) {
        final featuresLength = _getFeatures(context).length;
        setState(() {
          _currentPage = (_currentPage + 1) % featuresLength;
        });
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final features = _getFeatures(context);
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: features.length,
            itemBuilder: (context, index) {
              final feature = features[index];
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      feature.icon,
                      size: 48,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(height: 16),
                    Text(
                      feature.title,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      feature.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: 16),
        // Page indicators
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: features.asMap().entries.map((entry) {
        //     return GestureDetector(
        //       onTap: () {
        //         setState(() {
        //           _currentPage = entry.key;
        //         });
        //         _pageController.animateToPage(
        //           entry.key,
        //           duration: Duration(milliseconds: 300),
        //           curve: Curves.easeInOut,
        //         );
        //       },
        //       child: Container(
        //         width: 8,
        //         height: 8,
        //         margin: EdgeInsets.symmetric(horizontal: 4),
        //         decoration: BoxDecoration(
        //           shape: BoxShape.circle,
        //           color: _currentPage == entry.key
        //               ? Theme.of(context).colorScheme.primary
        //               : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
        //         ),
        //       ),
        //     );
        //   }).toList(),
        // ),
      ],
    );
  }
}

class _Feature {
  final IconData icon;
  final String title;
  final String description;

  _Feature({
    required this.icon,
    required this.title,
    required this.description,
  });
}
