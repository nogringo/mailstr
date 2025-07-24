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
  String get unlockWithCashu => 'Débloquer avec Cashu';

  @override
  String get cashuDescription =>
      'Cashu est de l\'argent électronique pour les paiements en ligne et dans le monde entier. C\'est Rapide, Privé, Simple et Sécurisé.';

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
  String get copyNsec => 'Copier le nsec';

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
    return '$appTitle ne lit ni ne scanne le contenu de vos emails d\'aucune manière, mais il est possible pour tout fournisseur d\'email de lire vos emails. Aucun fournisseur d\'email crypté n\'empêche cela : même s\'ils chiffrent les emails entrants avant de les stocker, le fournisseur reçoit toujours l\'email en texte brut en premier, ce qui signifie que vous n\'êtes protégé que si personne ne lisait ou ne copiait l\'email à son arrivée.';
  }

  @override
  String get noAccounts => 'Pas de compte';

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

  @override
  String get whereToReadEmails => 'Où lire mes emails ?';

  @override
  String get whereToReadEmailsDescription =>
      'Vos emails vous sont evoyés par message privé sur Nostr. Vous pouvez les lire sur n\'importe quelle application Nostr qui supporte les messages privés comme :';

  @override
  String get alreadyHaveNostrAccount =>
      'J\'ai déjà un compte Nostr, puis-je recevoir mes emails sur ce compte ?';

  @override
  String yesAddDomainToNpub(String domain) {
    return 'Oui, vous avez juste à ajouter @$domain à la fin de votre clé publique (Npub) et vous avez votre adresse email.';
  }

  @override
  String get loadingProfile => 'Chargement du profil...';

  @override
  String get goToMailbox => 'Aller à la boîte mail';

  @override
  String get appearance => 'Apparence';

  @override
  String get logout => 'Déconnexion';

  @override
  String get logoutConfirmation =>
      'Êtes-vous sûr de vouloir vous déconnecter ?';

  @override
  String get cancel => 'Annuler';

  @override
  String get themeMode => 'Mode de thème';

  @override
  String get light => 'Clair';

  @override
  String get dark => 'Sombre';

  @override
  String get system => 'Système';

  @override
  String get accentColor => 'Couleur d\'accent';

  @override
  String get defaultColor => 'Par défaut';

  @override
  String get picture => 'Image';

  @override
  String get banner => 'Bannière';

  @override
  String get mailbox => 'Boîte mail';

  @override
  String get login => 'Connexion';

  @override
  String get createYourAddress => 'Créez votre adresse';

  @override
  String get username => 'nom d\'utilisateur';

  @override
  String get private => 'Privé';

  @override
  String get hideFromPublicDirectory => 'Masquer du répertoire public';

  @override
  String get mailstrLogin => 'Connexion à Mailstr';

  @override
  String get loginWithNostr => 'Se connecter avec Nostr';

  @override
  String get message => 'Message';

  @override
  String get close => 'Fermer';

  @override
  String copiedToClipboard(String label) {
    return '$label copié dans le presse-papiers';
  }

  @override
  String get privateKeyWarning =>
      'Votre clé privée (Nsec) est la clé pour lire vos emails, conservez la dans un endroit sécurisé comme votre gestionnaire de mot de passe.';

  @override
  String get noAccessWithoutNsec =>
      'Sans votre Nsec vous n\'aurez pas accès à vos emails.';

  @override
  String get register => 'ENREGISTRER';

  @override
  String get connectWithNostr => 'Se connecter avec Nostr';

  @override
  String get secureDecentralizedAuth =>
      'Authentification sécurisée et décentralisée';

  @override
  String get signingCapabilityRequired => 'Capacité de signature requise';

  @override
  String get nip05AndPubkeyReadOnly =>
      'Les connexions NIP-05 et pubkey sont en lecture seule. Utilisez :';

  @override
  String get loginMethodsList =>
      '• Extension de navigateur (Alby, nos2x, etc.)\n• Générer de nouvelles clés\n• Importer une clé privée';

  @override
  String get signInToAccessMailbox =>
      'Connectez-vous pour accéder à la boîte mail';

  @override
  String get toReceiveAndSendMessages =>
      'Pour recevoir et envoyer des messages chiffrés, vous devez vous connecter avec un compte Nostr qui peut signer des messages.';

  @override
  String get noMessagesYet => 'Pas encore de messages';

  @override
  String get noAliasesYet => 'Pas encore d\'alias';

  @override
  String get tapPlusToCreateAlias =>
      'Appuyez sur + pour créer votre premier alias';

  @override
  String get limitedView => 'Vue limitée';

  @override
  String get youCanOnlySeeDefaultAliases =>
      'Vous ne pouvez voir que les alias par défaut. Pour voir tous vos alias, connectez-vous avec une capacité de signature.';

  @override
  String get tapToCopy => 'Appuyez pour copier';

  @override
  String get useThisAddressAsMyNostrAddress =>
      'Utiliser cette adresse comme mon adresse Nostr';

  @override
  String get unregisterAlias => 'Désinscrire l\'Alias';

  @override
  String get areYouSureUnregister => 'Êtes-vous sûr de vouloir désinscrire';

  @override
  String get aliasUnregistered => 'Alias désinscrit';

  @override
  String get failedToUnregisterAlias =>
      'Échec de la désinscription de l\'alias';

  @override
  String get unregister => 'Désinscrire';

  @override
  String get inbox => 'Boîte de réception';

  @override
  String get aliases => 'Alias';

  @override
  String get nostrUser => 'Utilisateur Nostr';

  @override
  String get welcomeToMyNostrProfile => 'Bienvenue sur mon profil Nostr';

  @override
  String get claimYourNip05 =>
      'Obtenez votre adresse Nostr NIP-05 dès maintenant et utilisez-la comme une adresse email.';

  @override
  String get claim => 'Obtenir';

  @override
  String get switchTo => 'Basculer vers';

  @override
  String get theme => 'thème';

  @override
  String get free => 'Gratuit';

  @override
  String get freeDescription => 'Aucun frais, aucun coût caché';

  @override
  String get noSubscription => 'Pas d\'abonnement';

  @override
  String get noSubscriptionDescription => 'Utilisez sans paiement mensuel';

  @override
  String get noLogsFeature => 'Pas de journaux';

  @override
  String get noLogsDescription => 'Votre vie privée est protégée';

  @override
  String get unlimitedAccounts => 'Comptes illimités';

  @override
  String get unlimitedAccountsDescription =>
      'Créez autant que vous en avez besoin';

  @override
  String get nostrBased => 'Basé sur Nostr';

  @override
  String get nostrBasedDescription => 'Construit sur un protocole décentralisé';

  @override
  String get anonymous => 'Anonyme';

  @override
  String get anonymousDescription => 'Aucune information personnelle requise';

  @override
  String get openSourceClient => 'Client open source';

  @override
  String get openSourceClientDescription => 'Transparent et vérifiable';

  @override
  String whyChooseMailstr(String appTitle) {
    return 'Oubliez les adresses emails jetables !';
  }

  @override
  String get whyChooseMailstrDescription =>
      'Mailstr est différent des autres services d\'email. Nous connaissons l\'importance de vos emails.\nC\'est pourquoi nous vous proposons un service unique au bénéfice de l\'utilisateur et non pas pour la surveillance ou la collecte de données.\n\nNous ne vous demanderons donc jamais vos informations personnelles et vous pourrez toujours créer et recevoir des emails 100% anonymes.\n\nVos adresses emails vous appartiennent et resteront actives sans aucun abonnement.\n\nNotre engagement, à nous, est de ne jamais les supprimer.';

  @override
  String get paymentFailed => 'Le paiement a échoué';

  @override
  String get trustedMints => '\n\nMints de confiance :\n';

  @override
  String get pleaseEnterAName => 'Veuillez entrer un nom';

  @override
  String get pleaseEnterAPublicKey => 'Veuillez entrer une clé publique';

  @override
  String get nameCanOnlyContain =>
      'Le nom ne peut contenir que des lettres, chiffres, tirets et underscores';

  @override
  String get invalidNpubFormat => 'Format npub invalide';

  @override
  String get invalidPublicKeyFormat =>
      'Format de clé publique invalide (utilisez hex ou npub)';

  @override
  String get nip05RegisteredSuccessfully => 'NIP-05 enregistré avec succès !';

  @override
  String get registrationFailed => 'Échec de l\'enregistrement';

  @override
  String get nameAlreadyTaken => 'Nom déjà pris pour ce domaine';

  @override
  String get networkError =>
      'Erreur réseau : Veuillez vérifier votre connexion';
}
