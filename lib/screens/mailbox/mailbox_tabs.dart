import 'package:flutter/material.dart';
import 'package:mailstr/screens/mailbox/tabs/mailbox_aliases_tab_view.dart';
import 'package:mailstr/screens/mailbox/tabs/mailbox_inbox_tab_view.dart';

class MailboxTab {
  final String label;
  final Widget icon;
  final Widget content;

  MailboxTab({required this.label, required this.icon, required this.content});
}

List<MailboxTab> mailboxTabs = [
  MailboxTab(
    label: "Inbox",
    icon: Icon(Icons.inbox),
    content: MailboxInboxTabView(),
  ),
  MailboxTab(
    label: "Aliases",
    icon: Icon(Icons.alternate_email),
    content: MailboxAliasesTabView(),
  ),
];
