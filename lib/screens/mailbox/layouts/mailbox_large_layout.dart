import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailstr/screens/mailbox/mailbox_controller.dart';
import 'package:mailstr/screens/mailbox/mailbox_tabs.dart';
import 'package:mailstr/widgets/user_avatar.dart';

class MailboxLargeLayout extends StatelessWidget {
  const MailboxLargeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: Text("Mailbox"),
          actions: [
            // User profile picture
            Container(
              margin: EdgeInsets.only(right: 8),
              child: UserAvatar(radius: 16),
            ),
          ],
        ),
        body: Row(
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
        ),
        floatingActionButton: MailboxController.to.selectedIndex.value == 1
            ? FloatingActionButton(
                onPressed: () => MailboxController.to.showCreateAliasDialog(context),
                child: const Icon(Icons.add),
              )
            : null,
      );
    });
  }
}
