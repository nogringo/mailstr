import 'package:flutter/material.dart';
import 'package:mailstr/l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:nip19/nip19.dart';
import 'package:mailstr/screens/create/create_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mailstr/widgets/content_padding_view.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateController>(
      init: CreateController(),
      builder: (c) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(double.infinity, kToolbarHeight),
            child: ContentPaddingView(
              maxWidth: 400,
              child: AppBar(
                surfaceTintColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                title: Text(AppLocalizations.of(context)!.create),
                titleSpacing: 8,
                actions: [
                  FilledButton(
                    onPressed: c.payNow,
                    child: Text(AppLocalizations.of(context)!.unlockNow),
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  EmailView(email: c.npubEmail),
                  SizedBox(height: 8),
                  EmailView(email: c.pubkeyEmail),
                  SizedBox(height: 8),
                  EmailView(email: c.compactEmail),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: c.newEmail,
                        label: Text(AppLocalizations.of(context)!.newEmail),
                        icon: Icon(Icons.refresh),
                      ),
                      SizedBox(width: 8),
                      TextButton.icon(
                        onPressed: () => c.copy(c.keypair.nsec),
                        label: Text(AppLocalizations.of(context)!.copyNsec),
                        icon: Icon(Icons.copy),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class EmailView extends StatelessWidget {
  final String email;

  const EmailView({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final atIndex = email.indexOf('@');
    final beforeAt = atIndex > 0 ? email.substring(0, atIndex) : '';
    final atAndAfter = atIndex > 0 ? email.substring(atIndex) : email;

    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 2,
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
        ),
        color: Theme.of(
          context,
        ).colorScheme.primaryContainer.withValues(alpha: 0.2),
      ),
      child: Row(
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.robotoMono(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                children: [
                  if (beforeAt.isNotEmpty)
                    TextSpan(
                      text: beforeAt,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                  TextSpan(text: atAndAfter),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              onPressed: () => CreateController.to.copy(email),
              icon: Icon(Icons.copy, size: 16),
            ),
          ),
        ],
      ),
    );
  }
}
