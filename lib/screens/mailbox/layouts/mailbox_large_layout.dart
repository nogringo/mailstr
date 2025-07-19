import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailstr/screens/mailbox/logout_button_view.dart';
import 'package:mailstr/screens/mailbox/mailbox_controller.dart';
import 'package:mailstr/screens/mailbox/mailbox_tabs.dart';

class MailboxLargeLayout extends StatelessWidget {
  const MailboxLargeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mailbox"),
        actions: [LogoutButtonView(), SizedBox(width: 8)],
      ),
      body: Obx(() {
        return Row(
          children: [
            NavigationRail(
              labelType: NavigationRailLabelType.all,
              destinations: mailboxTabs
                  .map(
                    (tab) => NavigationRailDestination(
                      icon: tab.icon,
                      label: Text(tab.label),
                    ),
                  )
                  .toList(),
              selectedIndex: MailboxController.to.selectedIndex.value,
              onDestinationSelected: (i) =>
                  MailboxController.to.selectedIndex.value = i,
            ),
            Expanded(
              child:
                  mailboxTabs[MailboxController.to.selectedIndex.value].content,
            ),
          ],
        );
      }),
    );
  }
}
