import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailstr/screens/mailbox/logout_button_view.dart';
import 'package:mailstr/screens/mailbox/mailbox_controller.dart';
import 'package:mailstr/screens/mailbox/mailbox_tabs.dart';

class MailboxSmallLayout extends StatelessWidget {
  const MailboxSmallLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mailbox"), actions: [LogoutButtonView(),SizedBox(width: 8,)],),
      body: Obx(() {
        return mailboxTabs[MailboxController.to.selectedIndex.value].content;
      }),
      bottomNavigationBar: NavigationBar(
        destinations: mailboxTabs
            .map(
              (tab) => NavigationDestination(icon: tab.icon, label: tab.label),
            )
            .toList(),
        selectedIndex: MailboxController.to.selectedIndex.value,
        onDestinationSelected: (i) =>
            MailboxController.to.selectedIndex.value = i,
      ),
    );
  }
}
