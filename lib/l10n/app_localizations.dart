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
  /// **'Cashu is electronic cash for payments online, in person, and around the world. It\'s Fast, Private, Simple and Secure.'**
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
  /// **'No Accounts'**
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
  /// **'Yes, you just have to add @{domain} at the end of your Npub and you have your email address.'**
  String yesAddDomainToNpub(String domain);
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
