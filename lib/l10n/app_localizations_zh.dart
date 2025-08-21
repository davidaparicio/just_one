// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '🎲 Just One';

  @override
  String get randomWordGenerator => '随机词汇生成器';

  @override
  String get tapTheDice => '点击骰子！';

  @override
  String get tapDice => '点击骰子生成新词';

  @override
  String get words => '词汇';

  @override
  String get languages => '语言';

  @override
  String get newWord => '新词汇';

  @override
  String get generating => '生成中...';

  @override
  String get loading => '加载中...';

  @override
  String get gameRules => '游戏规则';

  @override
  String get gotIt => '明白了！ 👍';

  @override
  String get generateNewWord => '生成一个新的随机词汇';

  @override
  String currentRandomWord(String word) {
    return '当前随机词汇：$word';
  }

  @override
  String get noWordGenerated => '尚未生成任何词汇';

  @override
  String get howToPlayTitle => '如何玩Just One';

  @override
  String get howToPlayContent =>
      '一起让一名玩家 - 活跃玩家 - 通过每人秘密地用可擦记号笔在板上写一个线索来猜出神秘词汇。\\n\\n在不相互商量的情况下选择你的线索，要有创意，不要写与其他玩家相同的线索。事实上，所有相同的线索在活跃玩家看到之前就会被取消。\\n\\n游戏结束时，根据找到的神秘词汇数量计算你的分数。';
}
