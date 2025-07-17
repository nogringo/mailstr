import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mailstr/app_routes.dart';
import 'package:toastification/toastification.dart';
import 'package:mailstr/config.dart';
import 'package:mailstr/l10n/app_localizations.dart';
import 'package:mailstr/screens/pay/pay_controller.dart';
import 'package:mailstr/widgets/content_padding_view.dart';
import 'package:url_launcher/url_launcher.dart';

class PayScreen extends StatelessWidget {
  const PayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String email = Get.parameters['email'] ?? '';
    final controller = Get.put(PayController());

    // print('PayScreen - Email parameter: $email');
    // print('PayScreen - All parameters: ${Get.parameters}');
    // print('PayScreen - Current route: ${Get.currentRoute}');

    return Obx(
      () => Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, kToolbarHeight),
          child: ContentPaddingView(
            maxWidth: 500,
            child: AppBar(
              surfaceTintColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              title: Text(
                controller.emailUnlocked.value
                    ? AppLocalizations.of(context)!.emailUnlocked
                    : AppLocalizations.of(context)!.emailLocked,
              ),
              titleSpacing: 8,
              actions: controller.emailUnlocked.value
                  ? [
                      Padding(
                        padding: EdgeInsetsGeometry.only(right: 8),
                        child: FilledButton(
                          onPressed: () => Get.offAllNamed(AppRoutes.home),
                          child: Text(AppLocalizations.of(context)!.home),
                        ),
                      ),
                    ]
                  : null,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 4, right: 8, left: 8, bottom: 100),
          child: ContentPaddingView(
            maxWidth: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  email,
                  style: GoogleFonts.robotoMono(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
                SizedBox(height: 16),
                Obx(
                  () => controller.emailUnlocked.value
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Get.theme.colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    size: 48,
                                    color: Get.theme.colorScheme.primary,
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    AppLocalizations.of(context)!.emailSuccessfullyUnlocked,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineSmall,
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    AppLocalizations.of(context)!.youCanNowReceiveEmails,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            PayWithProofOfWorkView(),
                            SizedBox(height: 16),
                            PayWithCashuView(),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PayWithProofOfWorkView extends StatelessWidget {
  const PayWithProofOfWorkView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PayController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppLocalizations.of(context)!.unlockWithProofOfWork,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          AppLocalizations.of(context)!.proofOfWorkDescription,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(height: 8),
        Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!controller.powCompleted.value) ...[
                Row(
                  children: [
                    controller.searchingCode.value
                        ? FilledButton(
                            onPressed: controller.stopProofOfWork,
                            child: Text(AppLocalizations.of(context)!.pauseProofOfWork),
                          )
                        : FilledButton(
                            onPressed: controller.startProofOfWork,
                            child: Text(
                              controller.nonce.value > 0
                                  ? AppLocalizations.of(context)!.resumeProofOfWork
                                  : AppLocalizations.of(context)!.startProofOfWork,
                            ),
                          ),
                  ],
                ),
              ],
              if (controller.searchingCode.value ||
                  controller.powCompleted.value) ...[
                SizedBox(height: 8),
                if (controller.searchingCode.value) LinearProgressIndicator(),
                if (controller.searchingCode.value) SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        controller.powStatus.value,
                        style: GoogleFonts.robotoMono(fontSize: 12),
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.duration(controller.miningDuration.value),
                      style: GoogleFonts.robotoMono(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }
}

class PayWithCashuView extends StatefulWidget {
  const PayWithCashuView({super.key});

  @override
  State<PayWithCashuView> createState() => _PayWithCashuViewState();
}

class _PayWithCashuViewState extends State<PayWithCashuView> {
  final TextEditingController tokenController = TextEditingController();
  final controller = Get.find<PayController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppLocalizations.of(context)!.payWithCashu,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          AppLocalizations.of(context)!.cashuDescription,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: () async {
              final Uri url = Uri.parse('https://cashu.space');
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              }
            },
            label: Text(AppLocalizations.of(context)!.cashuSpace),
            icon: Icon(Icons.launch),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              width: 2,
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.2),
            ),
            color: Theme.of(
              context,
            ).colorScheme.primaryContainer.withValues(alpha: 0.2),
          ),
          child: Stack(
            children: [
              TextField(
                controller: tokenController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  border: InputBorder.none,
                  hintText: AppLocalizations.of(context)!.pasteCashuTokenHint(unlockPrice, unlockPrice == 1 ? '' : 's'),
                ),
                maxLines: 10,
              ),
              Positioned(
                top: 4,
                right: 4,
                child: IconButton(
                  onPressed: () async {
                    final data = await Clipboard.getData(Clipboard.kTextPlain);
                    if (data?.text != null) {
                      tokenController.text = data!.text!;
                    }
                  },
                  icon: Icon(Icons.paste),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            FilledButton(
              onPressed: () {
                if (tokenController.text.isNotEmpty) {
                  controller.payWithCashu(tokenController.text);
                } else {
                  toastification.show(
                    title: Text(AppLocalizations.of(context)!.error),
                    description: Text(AppLocalizations.of(context)!.pleasePasteCashuToken),
                    type: ToastificationType.error,
                    style: ToastificationStyle.fillColored,
                    alignment: Alignment.bottomRight,
                    autoCloseDuration: Duration(seconds: 3),
                    applyBlurEffect: true,
                    primaryColor: Get.theme.colorScheme.error,
                    backgroundColor: Get.theme.colorScheme.onError,
                    closeButton: ToastCloseButton(
                      showType: CloseButtonShowType.none,
                    ),
                  );
                }
              },
              child: Text(AppLocalizations.of(context)!.submitPayment),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    tokenController.dispose();
    super.dispose();
  }
}
