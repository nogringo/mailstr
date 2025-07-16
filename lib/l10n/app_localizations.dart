import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
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

  /// Header for proof of work payment option
  ///
  /// In en, this message translates to:
  /// **'Pay with Proof Of Work'**
  String get payWithProofOfWork;

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

  /// Header for Cashu payment option
  ///
  /// In en, this message translates to:
  /// **'Pay with Cashu'**
  String get payWithCashu;

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
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
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
