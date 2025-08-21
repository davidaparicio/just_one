// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => '🎲 Just One';

  @override
  String get randomWordGenerator => 'Générateur de Mots Aléatoires';

  @override
  String get tapTheDice => 'Touchez le dé!';

  @override
  String get tapDice => 'Touchez le dé pour un nouveau mot';

  @override
  String get words => 'Mots';

  @override
  String get languages => 'Langues';

  @override
  String get newWord => 'Nouveau Mot';

  @override
  String get generating => 'Génération...';

  @override
  String get loading => 'Chargement...';

  @override
  String get gameRules => 'Règles du Jeu';

  @override
  String get gotIt => 'Compris! 👍';

  @override
  String get generateNewWord => 'Générer un nouveau mot aléatoire';

  @override
  String currentRandomWord(String word) {
    return 'Mot aléatoire actuel: $word';
  }

  @override
  String get noWordGenerated => 'Aucun mot généré pour l\'instant';

  @override
  String get howToPlayTitle => 'Comment Jouer à Just One';

  @override
  String get howToPlayContent =>
      'Ensemble, faites deviner un mot Mystère à l\'un des joueurs - le joueur actif - en écrivant chacun, secrètement, un indice sur votre chevalet avec un feutre effaçable (type Velleda).\\n\\nChoisissez votre indice sans vous concerter et faites preuve d\'originalité pour ne pas écrire le même indice qu\'un autre joueur. En effet, tous les indices identiques seront annulés avant même que le joueur actif ne puisse les voir.\\n\\nÀ la fin de la partie, calculez votre score en fonction du nombre de mots Mystère trouvés.';
}
