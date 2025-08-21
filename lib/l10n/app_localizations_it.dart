// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => '🎲 Just One';

  @override
  String get randomWordGenerator => 'Generatore di Parole Casuali';

  @override
  String get tapTheDice => 'Tocca il dado!';

  @override
  String get tapDice => 'Tocca il dado per nuova parola';

  @override
  String get words => 'Parole';

  @override
  String get languages => 'Lingue';

  @override
  String get newWord => 'Nuova Parola';

  @override
  String get generating => 'Generazione...';

  @override
  String get loading => 'Caricamento...';

  @override
  String get gameRules => 'Regole del Gioco';

  @override
  String get gotIt => 'Capito! 👍';

  @override
  String get generateNewWord => 'Genera una nuova parola casuale';

  @override
  String currentRandomWord(String word) {
    return 'Parola casuale attuale: $word';
  }

  @override
  String get noWordGenerated => 'Nessuna parola generata ancora';

  @override
  String get howToPlayTitle => 'Come Giocare a Just One';

  @override
  String get howToPlayContent =>
      'Insieme, fate indovinare una parola Misteriosa a un giocatore - il giocatore attivo - scrivendo ognuno, segretamente, un indizio sulla vostra lavagnetta con un pennarello cancellabile.\\n\\nScegliete il vostro indizio senza consultarvi e siate originali per non scrivere lo stesso indizio di un altro giocatore. Infatti, tutti gli indizi identici saranno cancellati prima ancora che il giocatore attivo possa vederli.\\n\\nAlla fine del gioco, calcolate il vostro punteggio in base al numero di parole Misteriose trovate.';
}
