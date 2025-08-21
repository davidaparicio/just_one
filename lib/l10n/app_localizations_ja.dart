// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => '🎲 Just One';

  @override
  String get randomWordGenerator => 'ランダム単語ジェネレーター';

  @override
  String get tapTheDice => 'サイコロをタップ！';

  @override
  String get tapDice => 'サイコロをタップして新しい単語';

  @override
  String get words => '単語';

  @override
  String get languages => '言語';

  @override
  String get newWord => '新しい単語';

  @override
  String get generating => '生成中...';

  @override
  String get loading => '読み込み中...';

  @override
  String get gameRules => 'ゲームルール';

  @override
  String get gotIt => '分かりました！ 👍';

  @override
  String get generateNewWord => '新しいランダムな単語を生成';

  @override
  String currentRandomWord(String word) {
    return '現在のランダム単語：$word';
  }

  @override
  String get noWordGenerated => 'まだ単語が生成されていません';

  @override
  String get howToPlayTitle => 'Just Oneの遊び方';

  @override
  String get howToPlayContent =>
      'みんなで、1人のプレイヤー（アクティブプレイヤー）に神秘の単語を当ててもらいます。消せるマーカーで、それぞれがこっそりとヒントをボードに書きます。\\n\\n相談せずにヒントを選び、他のプレイヤーと同じヒントを書かないよう独創的になってください。同じヒントはすべて、アクティブプレイヤーが見る前にキャンセルされます。\\n\\nゲーム終了時に、見つけた神秘の単語の数に基づいてスコアを計算します。';
}
