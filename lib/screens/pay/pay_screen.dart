import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toastification/toastification.dart';
import 'package:mailstr/screens/pay/pay_controller.dart';
import 'package:mailstr/widgets/content_padding_view.dart';
import 'package:url_launcher/url_launcher.dart';

class PayScreen extends StatelessWidget {
  const PayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String email = Get.parameters['email'] ?? '';
    final controller = Get.put(PayController());

    print('PayScreen - Email parameter: $email');
    print('PayScreen - All parameters: ${Get.parameters}');
    print('PayScreen - Current route: ${Get.currentRoute}');

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
                    ? "Email unlocked"
                    : "Email locked",
              ),
              titleSpacing: 8,
              actions: controller.emailUnlocked.value
                  ? [
                      IconButton(
                        icon: Icon(Icons.home),
                        onPressed: () => Get.offAllNamed('/'),
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
                                    'Email Successfully Unlocked!',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineSmall,
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'You can now receive emails at this address.',
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
          "Pay with Proof Of Work",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          "It's like mining Bitcoin !\nYour device will search a code, it will take several minutes and once found your email will be unlocked.",
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
                            child: Text("Pause Proof Of Work"),
                          )
                        : FilledButton(
                            onPressed: controller.startProofOfWork,
                            child: Text(
                              controller.nonce.value > 0
                                  ? "Resume Proof Of Work"
                                  : "Start Proof Of Work",
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
                      'Duration: ${controller.miningDuration.value}',
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
          "Pay with Cashu",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          "Cashu is electronic cash for payments online, in person, and around the world. It's Fast, Private, Simple and Secure.",
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
            label: Text("Cashu.space"),
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
                  hintText: "Paste your Cashu token here",
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
                    title: Text('Error'),
                    description: Text('Please paste a Cashu token'),
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
              child: Text('Submit Payment'),
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
