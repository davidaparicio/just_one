// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => '🎲 Just One';

  @override
  String get randomWordGenerator => 'Gerador de Palavras Aleatórias';

  @override
  String get tapTheDice => 'Toque no dado!';

  @override
  String get tapDice => 'Toque no dado para nova palavra';

  @override
  String get words => 'Palavras';

  @override
  String get languages => 'Idiomas';

  @override
  String get newWord => 'Nova Palavra';

  @override
  String get generating => 'Gerando...';

  @override
  String get loading => 'Carregando...';

  @override
  String get gameRules => 'Regras do Jogo';

  @override
  String get gotIt => 'Entendi! 👍';

  @override
  String get generateNewWord => 'Gera uma nova palavra aleatória';

  @override
  String currentRandomWord(String word) {
    return 'Palavra aleatória atual: $word';
  }

  @override
  String get noWordGenerated => 'Nenhuma palavra gerada ainda';

  @override
  String get howToPlayTitle => 'Como Jogar Just One';

  @override
  String get howToPlayContent =>
      'Juntos, façam um jogador - o jogador ativo - adivinhar uma palavra Misteriosa escrevendo cada um, secretamente, uma dica no seu quadro com uma caneta apagável.\\n\\nEscolham sua dica sem se consultarem e sejam originais para não escrever a mesma dica que outro jogador. De fato, todas as dicas idênticas serão canceladas antes mesmo que o jogador ativo possa vê-las.\\n\\nNo final do jogo, calculem sua pontuação com base no número de palavras Misteriosas encontradas.';
}
