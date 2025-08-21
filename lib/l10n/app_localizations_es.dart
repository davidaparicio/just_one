// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => '🎲 Just One';

  @override
  String get randomWordGenerator => 'Generador de Palabras Aleatorias';

  @override
  String get tapTheDice => '¡Toca el dado!';

  @override
  String get tapDice => 'Toca el dado para nueva palabra';

  @override
  String get words => 'Palabras';

  @override
  String get languages => 'Idiomas';

  @override
  String get newWord => 'Nueva Palabra';

  @override
  String get generating => 'Generando...';

  @override
  String get loading => 'Cargando...';

  @override
  String get gameRules => 'Reglas del Juego';

  @override
  String get gotIt => '¡Entendido! 👍';

  @override
  String get generateNewWord => 'Genera una nueva palabra aleatoria';

  @override
  String currentRandomWord(String word) {
    return 'Palabra aleatoria actual: $word';
  }

  @override
  String get noWordGenerated => 'Aún no se ha generado ninguna palabra';

  @override
  String get howToPlayTitle => 'Cómo Jugar Just One';

  @override
  String get howToPlayContent =>
      'Juntos, hagan que un jugador - el jugador activo - adivine una palabra Misteriosa escribiendo cada uno, en secreto, una pista en su tablero con un marcador borrable.\\n\\nElige tu pista sin consultarte con otros y sé original para no escribir la misma pista que otro jugador. De hecho, todas las pistas idénticas serán canceladas antes de que el jugador activo pueda verlas.\\n\\nAl final del juego, calcula tu puntuación según el número de palabras Misteriosas encontradas.';
}
