// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => '🎲 Just One';

  @override
  String get randomWordGenerator => 'Random Word Generator';

  @override
  String get tapTheDice => 'Tap the dice!';

  @override
  String get tapDice => 'Tap dice for new word';

  @override
  String get words => 'Words';

  @override
  String get languages => 'Languages';

  @override
  String get newWord => 'New Word';

  @override
  String get generating => 'Generating...';

  @override
  String get loading => 'Loading...';

  @override
  String get gameRules => 'Game Rules';

  @override
  String get gotIt => 'Got it! 👍';

  @override
  String get generateNewWord => 'Generate a new random word';

  @override
  String currentRandomWord(String word) {
    return 'Current random word: $word';
  }

  @override
  String get noWordGenerated => 'No word generated yet';

  @override
  String get howToPlayTitle => 'How to Play Just One';

  @override
  String get howToPlayContent =>
      'Together, make one player - the active player - guess a Mystery word by each secretly writing a clue on your board with an erasable marker.\\n\\nChoose your clue without consulting each other and be original so as not to write the same clue as another player. Indeed, all identical clues will be cancelled before the active player can even see them.\\n\\nAt the end of the game, calculate your score based on the number of Mystery words found.';
}
