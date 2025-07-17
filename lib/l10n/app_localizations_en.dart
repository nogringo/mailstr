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
  String get payWithCashu => 'Pay with Cashu';

  @override
  String get cashuDescription =>
      'Cashu is electronic cash for payments online, in person, and around the world. It\'s Fast, Private, Simple and Secure.';

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
    return 'You can\'t. $appTitle doesn\'t read or scan your e-mail content in any way, but it\'s possible for any e-mail provider to read your e-mail, so you\'ll just have to take our word for it. No \"encrypted e-mail\" provider is preventing this: even if they encrypt incoming mail before storing it, the provider still receives the e-mail in plaintext first, meaning you\'re only protected if you assume no one was reading or copying the e-mail as it came in.';
  }

  @override
  String get noAccounts => 'No Accounts';

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
  String get home => 'Home';
}
