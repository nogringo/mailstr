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
  String get unlockWithProofOfWork => 'Débloquer avec une Preuve de Travail';

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

  @override
  String get create => 'Créer';

  @override
  String get unlockNow => 'Débloquer maintenant';

  @override
  String get newEmail => 'Nouvel email';

  @override
  String get copyNsec => 'Copier nsec';

  @override
  String get nostrBasedEmailService => 'Service d\'email basé sur Nostr';

  @override
  String get createSecureEmailAddresses =>
      'Créez des adresses email sécurisées en utilisant les clés Nostr.';

  @override
  String whyAppTitle(String appTitle) {
    return 'Pourquoi $appTitle ?';
  }

  @override
  String whyAppTitleDescription(String appTitle) {
    return 'Les fournisseurs d\'email traditionnels contrôlent vos données et peuvent fermer votre compte à tout moment. $appTitle est différent. Basé sur le protocole Nostr, votre adresse email est générée à partir de clés cryptographiques que vous seul contrôlez - personne ne peut révoquer votre identité.\n\nOn ne vous demandera jamais de vérifier des informations personnelles car nous pensons que tout le monde devrait avoir accès aux emails sans devoir se connecter à l\'état de surveillance croissant. Notre travail ici est au service de cette idée.\n\nBeaucoup de services sont gratuits car ils se nourrissent de vos données personnelles pour le profit ou le contrôle.';
  }

  @override
  String get howCanITrustYou => 'Comment puis-je vous faire confiance ?';

  @override
  String trustDescription(String appTitle) {
    return 'Vous ne pouvez pas. $appTitle ne lit ni ne scanne le contenu de vos emails d\'aucune manière, mais il est possible pour tout fournisseur d\'email de lire vos emails, donc vous devrez nous faire confiance. Aucun fournisseur d\'email crypté n\'empêche cela : même s\'ils chiffrent les emails entrants avant de les stocker, le fournisseur reçoit toujours l\'email en texte brut en premier, ce qui signifie que vous n\'êtes protégé que si personne ne lisait ou ne copiait l\'email à son arrivée.';
  }

  @override
  String get noAccounts => 'Pas de comptes';

  @override
  String get noLogs => 'Pas de logs';

  @override
  String get justPrivacy => 'Juste la confidentialité';

  @override
  String get createEmailAddressNow => 'Créer une adresse email maintenant';

  @override
  String get takesLessThan30Seconds =>
      'Prend moins de 30 secondes. Aucune inscription requise.';

  @override
  String get youCanNowReceiveEmails =>
      'Vous pouvez maintenant recevoir des emails à cette adresse.';

  @override
  String get cashuSpace => 'Cashu.space';

  @override
  String get copied => 'Copié';

  @override
  String get startingProofOfWork => 'Démarrage de la Preuve de Travail...';

  @override
  String resumingProofOfWork(int nonce) {
    return 'Reprise de la Preuve de Travail du nonce : $nonce';
  }

  @override
  String proofOfWorkPaused(int nonce) {
    return 'Preuve de Travail mise en pause au nonce : $nonce';
  }

  @override
  String get proofOfWorkReset => 'Preuve de Travail réinitialisée';

  @override
  String proofOfWorkCompletedWithNonce(int nonce) {
    return 'Preuve de Travail terminée ! Nonce : $nonce';
  }

  @override
  String searchingWithHashRate(int nonce, String hashRate) {
    return 'Recherche... Nonce : $nonce | Taux de hachage : $hashRate H/s';
  }

  @override
  String errorDecodingNpub(String error) {
    return 'Erreur lors du décodage npub : $error';
  }

  @override
  String invalidPubkeyFormat(int length, String isHex) {
    return 'Format de clé publique invalide : longueur=$length, hex=$isHex';
  }

  @override
  String get invalidEmailFormat => 'Format d\'email invalide';

  @override
  String get success => 'Succès';

  @override
  String get paymentAcceptedEmailUnlocked =>
      'Paiement accepté, email déverrouillé !';

  @override
  String get emailUnlockedWithProofOfWork =>
      'Email déverrouillé avec Preuve de Travail !';

  @override
  String get failedToVerifyProofOfWork =>
      'Échec de la vérification de la preuve de travail';

  @override
  String get failedToConnectToServer => 'Échec de la connexion au serveur';

  @override
  String duration(String duration) {
    return 'Durée : $duration';
  }

  @override
  String get home => 'Accueil';
}
