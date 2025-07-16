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
  String get payWithProofOfWork => 'Pay with Proof Of Work';

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
}
