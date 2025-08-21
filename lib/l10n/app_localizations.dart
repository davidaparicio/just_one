import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_zh.dart';

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
    Locale('it'),
    Locale('ja'),
    Locale('pt'),
    Locale('zh'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'🎲 Just One'**
  String get appTitle;

  /// Main title text
  ///
  /// In en, this message translates to:
  /// **'Random Word Generator'**
  String get randomWordGenerator;

  /// Initial message when no word is generated
  ///
  /// In en, this message translates to:
  /// **'Tap the dice!'**
  String get tapTheDice;

  /// Hint text below the word card
  ///
  /// In en, this message translates to:
  /// **'Tap dice for new word'**
  String get tapDice;

  /// Stats label for word count
  ///
  /// In en, this message translates to:
  /// **'Words'**
  String get words;

  /// Stats label for language count
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get languages;

  /// Label for the floating action button
  ///
  /// In en, this message translates to:
  /// **'New Word'**
  String get newWord;

  /// Loading text when generating a new word
  ///
  /// In en, this message translates to:
  /// **'Generating...'**
  String get generating;

  /// Loading text when switching languages
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Tooltip and title for rules dialog
  ///
  /// In en, this message translates to:
  /// **'Game Rules'**
  String get gameRules;

  /// Button text to close rules dialog
  ///
  /// In en, this message translates to:
  /// **'Got it! 👍'**
  String get gotIt;

  /// Accessibility label and tooltip for generate button
  ///
  /// In en, this message translates to:
  /// **'Generate a new random word'**
  String get generateNewWord;

  /// Accessibility label for the word display
  ///
  /// In en, this message translates to:
  /// **'Current random word: {word}'**
  String currentRandomWord(String word);

  /// Accessibility text when no word is shown
  ///
  /// In en, this message translates to:
  /// **'No word generated yet'**
  String get noWordGenerated;

  /// Title for game rules dialog
  ///
  /// In en, this message translates to:
  /// **'How to Play Just One'**
  String get howToPlayTitle;

  /// Game rules content
  ///
  /// In en, this message translates to:
  /// **'Together, make one player - the active player - guess a Mystery word by each secretly writing a clue on your board with an erasable marker.\\n\\nChoose your clue without consulting each other and be original so as not to write the same clue as another player. Indeed, all identical clues will be cancelled before the active player can even see them.\\n\\nAt the end of the game, calculate your score based on the number of Mystery words found.'**
  String get howToPlayContent;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'en',
    'es',
    'fr',
    'it',
    'ja',
    'pt',
    'zh',
  ].contains(locale.languageCode);

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
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'pt':
      return AppLocalizationsPt();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
