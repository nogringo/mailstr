import 'package:flutter/material.dart';
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
                title: Text("Create"),
                titleSpacing: 8,
                actions: [
                  FilledButton(
                    onPressed: c.payNow,
                    child: Text("Pay now"),
                  ),
                  SizedBox(width: 8),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                        label: Text("New email"),
                        icon: Icon(Icons.refresh),
                      ),
                      SizedBox(width: 8),
                      TextButton.icon(
                        onPressed: () => c.copy(c.keypair.nsec),
                        label: Text("Copy nsec"),
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
          Expanded(child: Text(email, style: GoogleFonts.robotoMono())),
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
