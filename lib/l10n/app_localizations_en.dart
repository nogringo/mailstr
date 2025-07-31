// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get emailLocked => 'Email locked';

  @override
  String get emailUnlocked => 'Email unlocked';

  @override
  String get emailSuccessfullyUnlocked => 'Email Successfully Unlocked!';

  @override
  String get unlockWithProofOfWork => 'Unlock with Proof Of Work';

  @override
  String get proofOfWorkDescription =>
      'It\'s like mining Bitcoin !\nYour device will search a code, it will take several minutes and once found your email will be unlocked.';

  @override
  String get startProofOfWork => 'Start Proof Of Work';

  @override
  String get resumeProofOfWork => 'Resume Proof Of Work';

  @override
  String get pauseProofOfWork => 'Pause Proof Of Work';

  @override
  String get searchingForCode => 'Searching for code...';

  @override
  String nonceAttempts(int nonce) {
    return 'Nonce: $nonce';
  }

  @override
  String get proofOfWorkCompleted => 'Proof of Work Completed';

  @override
  String get unlockWithCashu => 'Pay with Cashu';

  @override
  String get cashuDescription =>
      'Cashu is electronic cash for payments online and around the world. It\'s Fast, Private, Simple and Secure.';

  @override
  String pasteCashuTokenHint(int amount, String plural) {
    return 'Paste a Cashu token worth $amount sat$plural to unlock';
  }

  @override
  String get submitPayment => 'Submit Payment';

  @override
  String get error => 'Error';

  @override
  String get pleasePasteCashuToken => 'Please paste a Cashu token';

  @override
  String get create => 'Create';

  @override
  String get unlockNow => 'Unlock now';

  @override
  String get newEmail => 'New email';

  @override
  String get copyNsec => 'Copy nsec';

  @override
  String get nostrBasedEmailService => 'Nostr based Email service';

  @override
  String get createSecureEmailAddresses =>
      'Create secure email addresses using Nostr keys.';

  @override
  String whyAppTitle(String appTitle) {
    return 'Why $appTitle?';
  }

  @override
  String whyAppTitleDescription(String appTitle) {
    return 'Traditional email providers control your data and can shut down your account at any time. $appTitle is different. Built on the Nostr protocol, your email address is generated from cryptographic keys only you control - no one can revoke your identity.\n\nYou will never be asked to verify personal information here because we believe anyone should have access to e-mail without requiring to connect it to the growing surveillance state. Our work here is in service to this idea.\n\nLots of services are free because they feast on your personal data for profit or control.';
  }

  @override
  String get howCanITrustYou => 'How can I trust you?';

  @override
  String trustDescription(String appTitle) {
    return '$appTitle doesn\'t read or scan your e-mail content in any way, but it\'s possible for any e-mail provider to read your e-mail, so you\'ll just have to take our word for it. No \"encrypted e-mail\" provider is preventing this: even if they encrypt incoming mail before storing it, the provider still receives the e-mail in plaintext first, meaning you\'re only protected if you assume no one was reading or copying the e-mail as it came in.';
  }

  @override
  String get noAccounts => 'No Account';

  @override
  String get noLogs => 'No Logs';

  @override
  String get justPrivacy => 'Just Privacy';

  @override
  String get createEmailAddressNow => 'Create An Email Address Now';

  @override
  String get takesLessThan30Seconds =>
      'Takes less than 30 seconds. No registration required.';

  @override
  String get youCanNowReceiveEmails =>
      'You can now receive emails at this address.';

  @override
  String get cashuSpace => 'Cashu.space';

  @override
  String get copied => 'Copied';

  @override
  String get startingProofOfWork => 'Starting Proof of Work...';

  @override
  String resumingProofOfWork(int nonce) {
    return 'Resuming Proof of Work from nonce: $nonce';
  }

  @override
  String proofOfWorkPaused(int nonce) {
    return 'Proof of Work paused at nonce: $nonce';
  }

  @override
  String get proofOfWorkReset => 'Proof of Work reset';

  @override
  String proofOfWorkCompletedWithNonce(int nonce) {
    return 'Proof of Work completed! Nonce: $nonce';
  }

  @override
  String searchingWithHashRate(int nonce, String hashRate) {
    return 'Searching... Nonce: $nonce | Hash rate: $hashRate H/s';
  }

  @override
  String errorDecodingNpub(String error) {
    return 'Error decoding npub: $error';
  }

  @override
  String invalidPubkeyFormat(int length, String isHex) {
    return 'Invalid pubkey format: length=$length, hex=$isHex';
  }

  @override
  String get invalidEmailFormat => 'Invalid email format';

  @override
  String get success => 'Success';

  @override
  String get paymentAcceptedEmailUnlocked =>
      'Payment accepted, email unlocked!';

  @override
  String get emailUnlockedWithProofOfWork =>
      'Email unlocked with Proof of Work!';

  @override
  String get failedToVerifyProofOfWork => 'Failed to verify proof of work';

  @override
  String get failedToConnectToServer => 'Failed to connect to server';

  @override
  String duration(String duration) {
    return 'Duration: $duration';
  }

  @override
  String estimatedTime(String time) {
    return 'Est. time: $time';
  }

  @override
  String get home => 'Home';

  @override
  String get whereToReadEmails => 'Where to read my emails?';

  @override
  String get whereToReadEmailsDescription =>
      'Your emails are sent to you via private message on Nostr. You can read them on any Nostr application that supports private messages like:';

  @override
  String get alreadyHaveNostrAccount =>
      'I already have a Nostr account, can I receive my emails on this account?';

  @override
  String yesAddDomainToNpub(String domain) {
    return 'Yes, you just have to add @$domain at the end of your public key (Npub) and you have your email address.';
  }

  @override
  String get loadingProfile => 'Loading profile...';

  @override
  String get goToMailbox => 'Go to Mailbox';

  @override
  String get appearance => 'Appearance';

  @override
  String get logout => 'Logout';

  @override
  String get logoutConfirmation => 'Are you sure you want to logout?';

  @override
  String get cancel => 'Cancel';

  @override
  String get themeMode => 'Theme Mode';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get system => 'System';

  @override
  String get accentColor => 'Accent Color';

  @override
  String get defaultColor => 'Default';

  @override
  String get picture => 'Picture';

  @override
  String get banner => 'Banner';

  @override
  String get mailbox => 'Mailbox';

  @override
  String get login => 'Login';

  @override
  String get createYourAddress => 'Create your address';

  @override
  String get username => 'username';

  @override
  String get private => 'Private';

  @override
  String get hideFromPublicDirectory => 'Hide from public directory';

  @override
  String get mailstrLogin => 'Mailstr Login';

  @override
  String get loginWithNostr => 'Login with Nostr';

  @override
  String get message => 'Message';

  @override
  String get close => 'Close';

  @override
  String copiedToClipboard(String label) {
    return '$label copied to clipboard';
  }

  @override
  String get privateKeyWarning =>
      'Your private key (Nsec) is the key to read your emails, keep it in a secure place like your password manager.';

  @override
  String get noAccessWithoutNsec =>
      'Without your Nsec you will not have access to your emails.';

  @override
  String get register => 'REGISTER';

  @override
  String get connectWithNostr => 'Connect with Nostr';

  @override
  String get secureDecentralizedAuth => 'Secure, decentralized authentication';

  @override
  String get signingCapabilityRequired => 'Signing capability required';

  @override
  String get nip05AndPubkeyReadOnly =>
      'NIP-05 and pubkey login are read-only. Use:';

  @override
  String get loginMethodsList =>
      '• Browser extension (Alby, nos2x, etc.)\n• Generate new keys\n• Import private key';

  @override
  String get signInToAccessMailbox => 'Sign in to Access Mailbox';

  @override
  String get toReceiveAndSendMessages =>
      'To receive and send encrypted messages, you need to log in with a Nostr account that can sign messages.';

  @override
  String get noMessagesYet => 'No messages yet';

  @override
  String get noAliasesYet => 'No aliases yet';

  @override
  String get tapPlusToCreateAlias => 'Tap + to create your first alias';

  @override
  String get limitedView => 'Limited View';

  @override
  String get youCanOnlySeeDefaultAliases =>
      'You can only see defaults aliases. To view all your aliases, log in with signing capability.';

  @override
  String get tapToCopy => 'Tap to copy';

  @override
  String get useThisAddressAsMyNostrAddress =>
      'Use this address as my Nostr address';

  @override
  String get unregisterAlias => 'Unregister Alias';

  @override
  String get areYouSureUnregister => 'Are you sure you want to unregister';

  @override
  String get aliasUnregistered => 'Alias unregistered';

  @override
  String get failedToUnregisterAlias => 'Failed to unregister alias';

  @override
  String get unregister => 'Unregister';

  @override
  String get inbox => 'Inbox';

  @override
  String get aliases => 'Aliases';

  @override
  String get nostrUser => 'Nostr User';

  @override
  String get welcomeToMyNostrProfile => 'Welcome to my Nostr profile';

  @override
  String get claimYourNip05 =>
      'Claim your NIP-05 Nostr address now and use it as your email.';

  @override
  String get claim => 'Claim';

  @override
  String get switchTo => 'Switch to';

  @override
  String get theme => 'theme';

  @override
  String get free => 'Free';

  @override
  String get freeDescription => 'No charges, no hidden fees';

  @override
  String get noSubscription => 'No subscription';

  @override
  String get noSubscriptionDescription => 'Use without monthly payments';

  @override
  String get noLogsFeature => 'No logs';

  @override
  String get noLogsDescription => 'Your privacy is protected';

  @override
  String get unlimitedAccounts => 'Unlimited accounts';

  @override
  String get unlimitedAccountsDescription => 'Create as many as you need';

  @override
  String get nostrBased => 'Nostr based';

  @override
  String get nostrBasedDescription => 'Built on decentralized protocol';

  @override
  String get anonymous => 'Anonymous';

  @override
  String get anonymousDescription => 'No personal info required';

  @override
  String get openSourceClient => 'Open source client';

  @override
  String get openSourceClientDescription => 'Transparent and auditable';

  @override
  String whyChooseMailstr(String appTitle) {
    return 'Why choose $appTitle?';
  }

  @override
  String get whyChooseMailstrDescription =>
      'Mailstr is different from other email services. We understand the importance of your emails. That\'s why we offer a unique service that benefits the user and not surveillance or data collection.\n\nWe will never ask for your personal information and you can always create and receive 100% anonymous emails.\n\nYour email addresses belong to you and will remain active without any subscription.\n\nOur commitment is to never delete them.';

  @override
  String get paymentFailed => 'Payment failed';

  @override
  String get trustedMints => '\n\nTrusted mints:\n';

  @override
  String get pleaseEnterAName => 'Please enter a name';

  @override
  String get pleaseEnterAPublicKey => 'Please enter a public key';

  @override
  String get nameCanOnlyContain =>
      'Name can only contain letters, numbers, hyphens and underscores';

  @override
  String get invalidNpubFormat => 'Invalid npub format';

  @override
  String get invalidPublicKeyFormat =>
      'Invalid public key format (use hex or npub)';

  @override
  String get nip05RegisteredSuccessfully => 'NIP-05 registered successfully!';

  @override
  String get registrationFailed => 'Registration failed';

  @override
  String get nameAlreadyTaken => 'Name already taken for this domain';

  @override
  String get networkError => 'Network error: Please check your connection';
}
