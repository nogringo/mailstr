import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('fr'),
  ];

  /// The conventional newborn programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Hello World!'**
  String get helloWorld;

  /// Title shown when email is locked
  ///
  /// In en, this message translates to:
  /// **'Email locked'**
  String get emailLocked;

  /// Title shown when email is unlocked
  ///
  /// In en, this message translates to:
  /// **'Email unlocked'**
  String get emailUnlocked;

  /// Message shown when email is successfully unlocked
  ///
  /// In en, this message translates to:
  /// **'Email Successfully Unlocked!'**
  String get emailSuccessfullyUnlocked;

  /// Header for proof of work unlock option
  ///
  /// In en, this message translates to:
  /// **'Unlock with Proof Of Work'**
  String get unlockWithProofOfWork;

  /// Description of proof of work payment method
  ///
  /// In en, this message translates to:
  /// **'It\'s like mining Bitcoin !\nYour device will search a code, it will take several minutes and once found your email will be unlocked.'**
  String get proofOfWorkDescription;

  /// Button to start proof of work
  ///
  /// In en, this message translates to:
  /// **'Start Proof Of Work'**
  String get startProofOfWork;

  /// Button to resume proof of work
  ///
  /// In en, this message translates to:
  /// **'Resume Proof Of Work'**
  String get resumeProofOfWork;

  /// Button to pause proof of work
  ///
  /// In en, this message translates to:
  /// **'Pause Proof Of Work'**
  String get pauseProofOfWork;

  /// Status message while searching for proof of work
  ///
  /// In en, this message translates to:
  /// **'Searching for code...'**
  String get searchingForCode;

  /// Shows current nonce attempt number
  ///
  /// In en, this message translates to:
  /// **'Nonce: {nonce}'**
  String nonceAttempts(int nonce);

  /// Message when proof of work is completed
  ///
  /// In en, this message translates to:
  /// **'Proof of Work Completed'**
  String get proofOfWorkCompleted;

  /// Header for Cashu unlock option
  ///
  /// In en, this message translates to:
  /// **'Unlock with Cashu'**
  String get unlockWithCashu;

  /// Description of Cashu payment method
  ///
  /// In en, this message translates to:
  /// **'Cashu is electronic cash for payments online and around the world. It\'s Fast, Private, Simple and Secure.'**
  String get cashuDescription;

  /// Hint text for Cashu token input field
  ///
  /// In en, this message translates to:
  /// **'Paste a Cashu token worth {amount} sat{plural} to unlock'**
  String pasteCashuTokenHint(int amount, String plural);

  /// Button to submit Cashu payment
  ///
  /// In en, this message translates to:
  /// **'Submit Payment'**
  String get submitPayment;

  /// Generic error title
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Error message when no Cashu token is provided
  ///
  /// In en, this message translates to:
  /// **'Please paste a Cashu token'**
  String get pleasePasteCashuToken;

  /// Create button text
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// Unlock now button text
  ///
  /// In en, this message translates to:
  /// **'Unlock now'**
  String get unlockNow;

  /// New email button text
  ///
  /// In en, this message translates to:
  /// **'New email'**
  String get newEmail;

  /// Copy nsec button text
  ///
  /// In en, this message translates to:
  /// **'Copy nsec'**
  String get copyNsec;

  /// Main headline on home screen
  ///
  /// In en, this message translates to:
  /// **'Nostr based Email service'**
  String get nostrBasedEmailService;

  /// Subtitle on home screen
  ///
  /// In en, this message translates to:
  /// **'Create secure email addresses using Nostr keys.'**
  String get createSecureEmailAddresses;

  /// Section title on home screen
  ///
  /// In en, this message translates to:
  /// **'Why {appTitle}?'**
  String whyAppTitle(String appTitle);

  /// Long description about why the app is different
  ///
  /// In en, this message translates to:
  /// **'Traditional email providers control your data and can shut down your account at any time. {appTitle} is different. Built on the Nostr protocol, your email address is generated from cryptographic keys only you control - no one can revoke your identity.\n\nYou will never be asked to verify personal information here because we believe anyone should have access to e-mail without requiring to connect it to the growing surveillance state. Our work here is in service to this idea.\n\nLots of services are free because they feast on your personal data for profit or control.'**
  String whyAppTitleDescription(String appTitle);

  /// Section title on home screen
  ///
  /// In en, this message translates to:
  /// **'How can I trust you?'**
  String get howCanITrustYou;

  /// Long description about trust and security
  ///
  /// In en, this message translates to:
  /// **'{appTitle} doesn\'t read or scan your e-mail content in any way, but it\'s possible for any e-mail provider to read your e-mail, so you\'ll just have to take our word for it. No \"encrypted e-mail\" provider is preventing this: even if they encrypt incoming mail before storing it, the provider still receives the e-mail in plaintext first, meaning you\'re only protected if you assume no one was reading or copying the e-mail as it came in.'**
  String trustDescription(String appTitle);

  /// Feature pill text
  ///
  /// In en, this message translates to:
  /// **'No Account'**
  String get noAccounts;

  /// Feature pill text
  ///
  /// In en, this message translates to:
  /// **'No Logs'**
  String get noLogs;

  /// Feature pill text
  ///
  /// In en, this message translates to:
  /// **'Just Privacy'**
  String get justPrivacy;

  /// Call to action button text
  ///
  /// In en, this message translates to:
  /// **'Create An Email Address Now'**
  String get createEmailAddressNow;

  /// Subtitle for call to action
  ///
  /// In en, this message translates to:
  /// **'Takes less than 30 seconds. No registration required.'**
  String get takesLessThan30Seconds;

  /// Success message after email unlock
  ///
  /// In en, this message translates to:
  /// **'You can now receive emails at this address.'**
  String get youCanNowReceiveEmails;

  /// Link text for Cashu website
  ///
  /// In en, this message translates to:
  /// **'Cashu.space'**
  String get cashuSpace;

  /// Toast message when something is copied
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get copied;

  /// Status message when starting proof of work
  ///
  /// In en, this message translates to:
  /// **'Starting Proof of Work...'**
  String get startingProofOfWork;

  /// Status message when resuming proof of work
  ///
  /// In en, this message translates to:
  /// **'Resuming Proof of Work from nonce: {nonce}'**
  String resumingProofOfWork(int nonce);

  /// Status message when proof of work is paused
  ///
  /// In en, this message translates to:
  /// **'Proof of Work paused at nonce: {nonce}'**
  String proofOfWorkPaused(int nonce);

  /// Status message when proof of work is reset
  ///
  /// In en, this message translates to:
  /// **'Proof of Work reset'**
  String get proofOfWorkReset;

  /// Status message when proof of work is completed
  ///
  /// In en, this message translates to:
  /// **'Proof of Work completed! Nonce: {nonce}'**
  String proofOfWorkCompletedWithNonce(int nonce);

  /// Status message showing search progress with hash rate
  ///
  /// In en, this message translates to:
  /// **'Searching... Nonce: {nonce} | Hash rate: {hashRate} H/s'**
  String searchingWithHashRate(int nonce, String hashRate);

  /// Error message when decoding npub fails
  ///
  /// In en, this message translates to:
  /// **'Error decoding npub: {error}'**
  String errorDecodingNpub(String error);

  /// Error message for invalid pubkey format
  ///
  /// In en, this message translates to:
  /// **'Invalid pubkey format: length={length}, hex={isHex}'**
  String invalidPubkeyFormat(int length, String isHex);

  /// Error message for invalid email format
  ///
  /// In en, this message translates to:
  /// **'Invalid email format'**
  String get invalidEmailFormat;

  /// Success toast title
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// Success message when payment is accepted
  ///
  /// In en, this message translates to:
  /// **'Payment accepted, email unlocked!'**
  String get paymentAcceptedEmailUnlocked;

  /// Success message when email is unlocked with proof of work
  ///
  /// In en, this message translates to:
  /// **'Email unlocked with Proof of Work!'**
  String get emailUnlockedWithProofOfWork;

  /// Error message when proof of work verification fails
  ///
  /// In en, this message translates to:
  /// **'Failed to verify proof of work'**
  String get failedToVerifyProofOfWork;

  /// Error message when server connection fails
  ///
  /// In en, this message translates to:
  /// **'Failed to connect to server'**
  String get failedToConnectToServer;

  /// Duration label showing elapsed time
  ///
  /// In en, this message translates to:
  /// **'Duration: {duration}'**
  String duration(String duration);

  /// Home button text
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Section title asking where to read emails
  ///
  /// In en, this message translates to:
  /// **'Where to read my emails?'**
  String get whereToReadEmails;

  /// Description explaining how to read emails via Nostr apps
  ///
  /// In en, this message translates to:
  /// **'Your emails are sent to you via private message on Nostr. You can read them on any Nostr application that supports private messages like:'**
  String get whereToReadEmailsDescription;

  /// Question about using existing Nostr account
  ///
  /// In en, this message translates to:
  /// **'I already have a Nostr account, can I receive my emails on this account?'**
  String get alreadyHaveNostrAccount;

  /// Answer explaining how to create email from existing Npub
  ///
  /// In en, this message translates to:
  /// **'Yes, you just have to add @{domain} at the end of your public key (Npub) and you have your email address.'**
  String yesAddDomainToNpub(String domain);

  /// Loading message when fetching user profile
  ///
  /// In en, this message translates to:
  /// **'Loading profile...'**
  String get loadingProfile;

  /// Button to navigate to mailbox
  ///
  /// In en, this message translates to:
  /// **'Go to Mailbox'**
  String get goToMailbox;

  /// Settings section for appearance options
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// Logout button text
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Confirmation message for logout dialog
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logoutConfirmation;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Settings label for theme mode selection
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get themeMode;

  /// Light theme option
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// Dark theme option
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// System theme option
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// Settings label for accent color selection
  ///
  /// In en, this message translates to:
  /// **'Accent Color'**
  String get accentColor;

  /// Default color option
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get defaultColor;

  /// Picture-based color option
  ///
  /// In en, this message translates to:
  /// **'Picture'**
  String get picture;

  /// Banner-based color option
  ///
  /// In en, this message translates to:
  /// **'Banner'**
  String get banner;

  /// Mailbox navigation button
  ///
  /// In en, this message translates to:
  /// **'Mailbox'**
  String get mailbox;

  /// Login button text
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Title for create address screen
  ///
  /// In en, this message translates to:
  /// **'Create your address'**
  String get createYourAddress;

  /// Username text field hint
  ///
  /// In en, this message translates to:
  /// **'username'**
  String get username;

  /// Private toggle label
  ///
  /// In en, this message translates to:
  /// **'Private'**
  String get private;

  /// Description for private toggle
  ///
  /// In en, this message translates to:
  /// **'Hide from public directory'**
  String get hideFromPublicDirectory;

  /// Login screen title
  ///
  /// In en, this message translates to:
  /// **'Mailstr Login'**
  String get mailstrLogin;

  /// Button to login with Nostr
  ///
  /// In en, this message translates to:
  /// **'Login with Nostr'**
  String get loginWithNostr;

  /// Dialog title for messages
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// Close button text
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// Toast message when something is copied
  ///
  /// In en, this message translates to:
  /// **'{label} copied to clipboard'**
  String copiedToClipboard(String label);

  /// Warning about private key security
  ///
  /// In en, this message translates to:
  /// **'Your private key (Nsec) is the key to read your emails, keep it in a secure place like your password manager.'**
  String get privateKeyWarning;

  /// Warning about losing access without Nsec
  ///
  /// In en, this message translates to:
  /// **'Without your Nsec you will not have access to your emails.'**
  String get noAccessWithoutNsec;

  /// Register button text
  ///
  /// In en, this message translates to:
  /// **'REGISTER'**
  String get register;

  /// Login screen title
  ///
  /// In en, this message translates to:
  /// **'Connect with Nostr'**
  String get connectWithNostr;

  /// Login screen subtitle
  ///
  /// In en, this message translates to:
  /// **'Secure, decentralized authentication'**
  String get secureDecentralizedAuth;

  /// Warning title for read-only login methods
  ///
  /// In en, this message translates to:
  /// **'Signing capability required'**
  String get signingCapabilityRequired;

  /// Warning message about read-only login methods
  ///
  /// In en, this message translates to:
  /// **'NIP-05 and pubkey login are read-only. Use:'**
  String get nip05AndPubkeyReadOnly;

  /// List of login methods that support signing
  ///
  /// In en, this message translates to:
  /// **'• Browser extension (Alby, nos2x, etc.)\n• Generate new keys\n• Import private key'**
  String get loginMethodsList;

  /// Title prompting user to sign in to access mailbox
  ///
  /// In en, this message translates to:
  /// **'Sign in to Access Mailbox'**
  String get signInToAccessMailbox;

  /// Description explaining why signing capability is needed
  ///
  /// In en, this message translates to:
  /// **'To receive and send encrypted messages, you need to log in with a Nostr account that can sign messages.'**
  String get toReceiveAndSendMessages;

  /// Empty state message for inbox
  ///
  /// In en, this message translates to:
  /// **'No messages yet'**
  String get noMessagesYet;

  /// Empty state message for aliases
  ///
  /// In en, this message translates to:
  /// **'No aliases yet'**
  String get noAliasesYet;

  /// Hint text to create first alias
  ///
  /// In en, this message translates to:
  /// **'Tap + to create your first alias'**
  String get tapPlusToCreateAlias;

  /// Title for limited view warning
  ///
  /// In en, this message translates to:
  /// **'Limited View'**
  String get limitedView;

  /// Warning message about limited alias view
  ///
  /// In en, this message translates to:
  /// **'You can only see defaults aliases. To view all your aliases, log in with signing capability.'**
  String get youCanOnlySeeDefaultAliases;

  /// Hint text for copying aliases
  ///
  /// In en, this message translates to:
  /// **'Tap to copy'**
  String get tapToCopy;

  /// Toggle option to use address as NIP-05 identifier
  ///
  /// In en, this message translates to:
  /// **'Use this address as my Nostr address'**
  String get useThisAddressAsMyNostrAddress;

  /// Dialog title for unregistering alias
  ///
  /// In en, this message translates to:
  /// **'Unregister Alias'**
  String get unregisterAlias;

  /// Confirmation message for alias unregistration
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to unregister'**
  String get areYouSureUnregister;

  /// Success message when alias is unregistered
  ///
  /// In en, this message translates to:
  /// **'Alias unregistered'**
  String get aliasUnregistered;

  /// Error message when alias unregistration fails
  ///
  /// In en, this message translates to:
  /// **'Failed to unregister alias'**
  String get failedToUnregisterAlias;

  /// Button text to unregister alias
  ///
  /// In en, this message translates to:
  /// **'Unregister'**
  String get unregister;

  /// Inbox tab label
  ///
  /// In en, this message translates to:
  /// **'Inbox'**
  String get inbox;

  /// Aliases tab label
  ///
  /// In en, this message translates to:
  /// **'Aliases'**
  String get aliases;

  /// Default display name for Nostr user
  ///
  /// In en, this message translates to:
  /// **'Nostr User'**
  String get nostrUser;

  /// Default about text for Nostr user profile
  ///
  /// In en, this message translates to:
  /// **'Welcome to my Nostr profile'**
  String get welcomeToMyNostrProfile;

  /// Text for NIP-05 claim banner
  ///
  /// In en, this message translates to:
  /// **'Claim your NIP-05 Nostr address now and use it as your email.'**
  String get claimYourNip05;

  /// Claim button text
  ///
  /// In en, this message translates to:
  /// **'Claim'**
  String get claim;

  /// Prefix for theme switch tooltip
  ///
  /// In en, this message translates to:
  /// **'Switch to'**
  String get switchTo;

  /// Suffix for theme switch tooltip
  ///
  /// In en, this message translates to:
  /// **'theme'**
  String get theme;

  /// Feature title for free service
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get free;

  /// Feature description for free service
  ///
  /// In en, this message translates to:
  /// **'No charges, no hidden fees'**
  String get freeDescription;

  /// Feature title for no subscription
  ///
  /// In en, this message translates to:
  /// **'No subscription'**
  String get noSubscription;

  /// Feature description for no subscription
  ///
  /// In en, this message translates to:
  /// **'Use without monthly payments'**
  String get noSubscriptionDescription;

  /// Feature title for no logs
  ///
  /// In en, this message translates to:
  /// **'No logs'**
  String get noLogsFeature;

  /// Feature description for no logs
  ///
  /// In en, this message translates to:
  /// **'Your privacy is protected'**
  String get noLogsDescription;

  /// Feature title for unlimited accounts
  ///
  /// In en, this message translates to:
  /// **'Unlimited accounts'**
  String get unlimitedAccounts;

  /// Feature description for unlimited accounts
  ///
  /// In en, this message translates to:
  /// **'Create as many as you need'**
  String get unlimitedAccountsDescription;

  /// Feature title for Nostr based
  ///
  /// In en, this message translates to:
  /// **'Nostr based'**
  String get nostrBased;

  /// Feature description for Nostr based
  ///
  /// In en, this message translates to:
  /// **'Built on decentralized protocol'**
  String get nostrBasedDescription;

  /// Feature title for anonymous
  ///
  /// In en, this message translates to:
  /// **'Anonymous'**
  String get anonymous;

  /// Feature description for anonymous
  ///
  /// In en, this message translates to:
  /// **'No personal info required'**
  String get anonymousDescription;

  /// Feature title for open source
  ///
  /// In en, this message translates to:
  /// **'Open source client'**
  String get openSourceClient;

  /// Feature description for open source
  ///
  /// In en, this message translates to:
  /// **'Transparent and auditable'**
  String get openSourceClientDescription;

  /// Section title for why choose Mailstr
  ///
  /// In en, this message translates to:
  /// **'Why choose {appTitle}?'**
  String whyChooseMailstr(String appTitle);

  /// Long description about why Mailstr is different
  ///
  /// In en, this message translates to:
  /// **'Mailstr is different from other email services. We understand the importance of your emails. That\'s why we offer a unique service that benefits the user and not surveillance or data collection.\n\nWe will never ask for your personal information and you can always create and receive 100% anonymous emails.\n\nYour email addresses belong to you and will remain active without any subscription.\n\nOur commitment is to never delete them.'**
  String get whyChooseMailstrDescription;

  /// Error message when payment fails
  ///
  /// In en, this message translates to:
  /// **'Payment failed'**
  String get paymentFailed;

  /// Header for list of trusted mints
  ///
  /// In en, this message translates to:
  /// **'\n\nTrusted mints:\n'**
  String get trustedMints;

  /// Validation error for empty name field
  ///
  /// In en, this message translates to:
  /// **'Please enter a name'**
  String get pleaseEnterAName;

  /// Validation error for empty public key field
  ///
  /// In en, this message translates to:
  /// **'Please enter a public key'**
  String get pleaseEnterAPublicKey;

  /// Validation error for invalid name format
  ///
  /// In en, this message translates to:
  /// **'Name can only contain letters, numbers, hyphens and underscores'**
  String get nameCanOnlyContain;

  /// Error when npub format is invalid
  ///
  /// In en, this message translates to:
  /// **'Invalid npub format'**
  String get invalidNpubFormat;

  /// Error for invalid public key format
  ///
  /// In en, this message translates to:
  /// **'Invalid public key format (use hex or npub)'**
  String get invalidPublicKeyFormat;

  /// Success message when NIP-05 is registered
  ///
  /// In en, this message translates to:
  /// **'NIP-05 registered successfully!'**
  String get nip05RegisteredSuccessfully;

  /// Generic registration failure message
  ///
  /// In en, this message translates to:
  /// **'Registration failed'**
  String get registrationFailed;

  /// Error when name is already taken
  ///
  /// In en, this message translates to:
  /// **'Name already taken for this domain'**
  String get nameAlreadyTaken;

  /// Error message for network issues
  ///
  /// In en, this message translates to:
  /// **'Network error: Please check your connection'**
  String get networkError;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
