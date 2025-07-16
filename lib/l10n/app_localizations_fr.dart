// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get helloWorld => 'Bonjour monde';

  @override
  String get emailLocked => 'Email verrouillé';

  @override
  String get emailUnlocked => 'Email déverrouillé';

  @override
  String get emailSuccessfullyUnlocked => 'Email déverrouillé avec succès !';

  @override
  String get payWithProofOfWork => 'Payer avec Preuve de Travail';

  @override
  String get proofOfWorkDescription =>
      'C\'est comme miner du Bitcoin !\nVotre appareil cherchera un code, cela prendra plusieurs minutes et une fois trouvé, votre email sera déverrouillé.';

  @override
  String get startProofOfWork => 'Démarrer la Preuve de Travail';

  @override
  String get resumeProofOfWork => 'Reprendre la Preuve de Travail';

  @override
  String get pauseProofOfWork => 'Mettre en pause la Preuve de Travail';

  @override
  String get searchingForCode => 'Recherche du code...';

  @override
  String nonceAttempts(int nonce) {
    return 'Nonce : $nonce';
  }

  @override
  String get proofOfWorkCompleted => 'Preuve de Travail terminée';

  @override
  String get payWithCashu => 'Payer avec Cashu';

  @override
  String get cashuDescription =>
      'Cashu est de l\'argent électronique pour les paiements en ligne, en personne et dans le monde entier. C\'est Rapide, Privé, Simple et Sécurisé.';

  @override
  String pasteCashuTokenHint(int amount, String plural) {
    return 'Collez un jeton Cashu d\'une valeur de $amount sat$plural pour déverrouiller';
  }

  @override
  String get submitPayment => 'Soumettre le paiement';

  @override
  String get error => 'Erreur';

  @override
  String get pleasePasteCashuToken => 'Veuillez coller un jeton Cashu';
}
