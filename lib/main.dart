import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:ui' as ui;

import 'l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Just One',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('es'), // Spanish
        Locale('fr'), // French
        Locale('it'), // Italian
        Locale('pt'), // Portuguese
        Locale('zh'), // Chinese
        Locale('ja'), // Japanese
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          backgroundColor: Color(0xFF6366F1),
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  math.Random random = math.Random();
  String _pickWord = "";
  bool initFile = false;
  List<String> arr = <String>[];
  String currentLanguage = "english";
  bool _isGenerating = false;
  
  String _getDisplayText(AppLocalizations l10n) {
    if (_pickWord.isEmpty || _pickWord == "...") {
      return l10n.tapTheDice;
    }
    if (_pickWord == "Loading..." || _pickWord == "Loading words...") {
      return l10n.loading;
    }
    return _pickWord;
  }
  
  String _getAccessibilityText(AppLocalizations l10n) {
    if (_pickWord.isEmpty || _pickWord == "..." || _pickWord == "Loading..." || _pickWord == "Loading words...") {
      return l10n.noWordGenerated;
    }
    return _pickWord;
  }
  
  final Map<String, String> languageFiles = {
    'en': 'english.txt',
    'es': 'spanish.txt',
    'it': 'italian.txt',
    'pt': 'portuguese.txt',
    'zh': 'chinese.txt',
    'ja': 'japanese.txt',
    'fr': 'french.txt',
  };
  
  final Map<String, String> languageNames = {
    'english': '🇺🇸 English',
    'spanish': '🇪🇸 Español',
    'italian': '🇮🇹 Italiano',
    'portuguese': '🇵🇹 Português',
    'chinese': '🇨🇳 中文',
    'japanese': '🇯🇵 日本語',
    'french': '🇫🇷 Français',
  };
  
  final Map<String, Map<String, String>> gameRules = {
    'english': {
      'title': 'How to Play Just One',
      'content': 'Together, make one player - the active player - guess a Mystery word by each secretly writing a clue on your board with an erasable marker.\n\nChoose your clue without consulting each other and be original so as not to write the same clue as another player. Indeed, all identical clues will be cancelled before the active player can even see them.\n\nAt the end of the game, calculate your score based on the number of Mystery words found.'
    },
    'spanish': {
      'title': 'Cómo Jugar Just One',
      'content': 'Juntos, hagan que un jugador - el jugador activo - adivine una palabra Misteriosa escribiendo cada uno, en secreto, una pista en su tablero con un marcador borrable.\n\nElige tu pista sin consultarte con otros y sé original para no escribir la misma pista que otro jugador. De hecho, todas las pistas idénticas serán canceladas antes de que el jugador activo pueda verlas.\n\nAl final del juego, calcula tu puntuación según el número de palabras Misteriosas encontradas.'
    },
    'italian': {
      'title': 'Come Giocare a Just One',
      'content': 'Insieme, fate indovinare una parola Misteriosa a un giocatore - il giocatore attivo - scrivendo ognuno, segretamente, un indizio sulla vostra lavagnetta con un pennarello cancellabile.\n\nScegliete il vostro indizio senza consultarvi e siate originali per non scrivere lo stesso indizio di un altro giocatore. Infatti, tutti gli indizi identici saranno cancellati prima ancora che il giocatore attivo possa vederli.\n\nAlla fine del gioco, calcolate il vostro punteggio in base al numero di parole Misteriose trovate.'
    },
    'portuguese': {
      'title': 'Como Jogar Just One',
      'content': 'Juntos, façam um jogador - o jogador ativo - adivinhar uma palavra Misteriosa escrevendo cada um, secretamente, uma dica no seu quadro com uma caneta apagável.\n\nEscolham sua dica sem se consultarem e sejam originais para não escrever a mesma dica que outro jogador. De fato, todas as dicas idênticas serão canceladas antes mesmo que o jogador ativo possa vê-las.\n\nNo final do jogo, calculem sua pontuação com base no número de palavras Misteriosas encontradas.'
    },
    'chinese': {
      'title': '如何玩Just One',
      'content': '一起让一名玩家 - 活跃玩家 - 通过每人秘密地用可擦记号笔在板上写一个线索来猜出神秘词汇。\n\n在不相互商量的情况下选择你的线索，要有创意，不要写与其他玩家相同的线索。事实上，所有相同的线索在活跃玩家看到之前就会被取消。\n\n游戏结束时，根据找到的神秘词汇数量计算你的分数。'
    },
    'japanese': {
      'title': 'Just Oneの遊び方',
      'content': 'みんなで、1人のプレイヤー（アクティブプレイヤー）に神秘の単語を当ててもらいます。消せるマーカーで、それぞれがこっそりとヒントをボードに書きます。\n\n相談せずにヒントを選び、他のプレイヤーと同じヒントを書かないよう独創的になってください。同じヒントはすべて、アクティブプレイヤーが見る前にキャンセルされます。\n\nゲーム終了時に、見つけた神秘の単語の数に基づいてスコアを計算します。'
    },
    'french': {
      'title': 'Comment Jouer à Just One',
      'content': 'Ensemble, faites deviner un mot Mystère à l\'un des joueurs - le joueur actif - en écrivant chacun, secrètement, un indice sur votre chevalet avec un feutre effaçable (type Velleda).\n\nChoisissez votre indice sans vous concerter et faites preuve d\'originalité pour ne pas écrire le même indice qu\'un autre joueur. En effet, tous les indices identiques seront annulés avant même que le joueur actif ne puisse les voir.\n\nÀ la fin de la partie, calculez votre score en fonction du nombre de mots Mystère trouvés.'
    },
  };
  
  /*int _counter = 0;
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });*/

  void _newRandom() async {
    if (initFile == true && arr.isNotEmpty) {
      setState(() {
        _isGenerating = true;
      });
      
      await Future.delayed(const Duration(milliseconds: 300));
      
      setState(() {
        _pickWord = arr[random.nextInt(arr.length)];
        _isGenerating = false;
      });
    } else {
      setState(() {
        _pickWord = "Loading words...";
      });
    }
  }

  Future<void> readFileAsync(String filename) async {
    try {
      String fileText = await rootBundle.loadString('assets/$filename');
      arr = fileText.split('\n');
    } catch (e) {
      String fileText = await rootBundle.loadString('assets/english.txt');
      arr = fileText.split('\n');
      currentLanguage = "english";
    }
  }
  
  Future<void> changeLanguage(String newLanguage) async {
    setState(() {
      currentLanguage = newLanguage;
      _pickWord = "Loading...";
      _isGenerating = true;
    });
    await readFileAsync('$newLanguage.txt');
    await Future.delayed(const Duration(milliseconds: 500));
    _newRandom();
  }
  
  void _showRulesDialog() {
    final l10n = AppLocalizations.of(context)!;
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF6366F1),
                  Color(0xFF8B5CF6),
                ],
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.help_outline,
                      color: Colors.white,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        l10n.howToPlayTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  constraints: const BoxConstraints(maxHeight: 400),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      l10n.howToPlayContent,
                      style: const TextStyle(
                        color: Color(0xFF1F2937),
                        fontSize: 16,
                        height: 1.6,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF6366F1),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      l10n.gotIt,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _initializeFile();
  }

  void _initializeFile() async {
    if (!initFile) {
      await _detectLanguageAndLoadFile();
      setState(() {
        _pickWord = "...";
        initFile = true;
      });
    }
  }
  
  Future<void> _detectLanguageAndLoadFile() async {
    String deviceLanguage = ui.PlatformDispatcher.instance.locale.languageCode;
    
    String filename = languageFiles[deviceLanguage] ?? 'english.txt';
    currentLanguage = filename.split('.').first;
    
    await readFileAsync(filename);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.appTitle,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF6366F1),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _showRulesDialog,
            icon: const Icon(Icons.help_outline),
            tooltip: l10n.gameRules,
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.language),
            onSelected: (String language) {
              changeLanguage(language);
            },
            itemBuilder: (BuildContext context) {
              return languageNames.entries.map((entry) {
                return PopupMenuItem<String>(
                  value: entry.key,
                  child: Row(
                    children: [
                      Text(entry.value),
                      if (currentLanguage == entry.key)
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Icon(Icons.check, color: Colors.green),
                        ),
                    ],
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF6366F1),
              Color(0xFF8B5CF6),
              Color(0xFFA855F7),
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (builderContext, constraints) {
              bool isTablet = constraints.maxWidth > 600;
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 48.0 : 24.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                // Header section
                Column(
                  children: [
                    const Icon(
                      Icons.casino,
                      size: 48,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.randomWordGenerator,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isTablet ? 36 : 28,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      languageNames[currentLanguage] ?? currentLanguage,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 48),
                
                // Word display card
                Semantics(
                  label: 'Current random word: ${_pickWord.isEmpty ? "No word generated yet" : _pickWord}',
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? 48 : 32,
                      vertical: isTablet ? 32 : 24,
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: isTablet ? 32 : 16,
                    ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          return ScaleTransition(
                            scale: animation,
                            child: FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                          );
                        },
                        child: _isGenerating
                            ? const SizedBox(
                                height: 60,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Color(0xFF6366F1),
                                    ),
                                  ),
                                ),
                              )
                            : Text(
                                _getDisplayText(l10n),
                                key: ValueKey(_pickWord),
                                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                  color: const Color(0xFF1F2937),
                                  fontWeight: FontWeight.bold,
                                  fontSize: isTablet ? 40 : 32,
                                ),
                                textAlign: TextAlign.center,
                              ),
                      ),
                      if (_pickWord.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6366F1).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            l10n.tapDice,
                            style: TextStyle(
                              color: const Color(0xFF6366F1),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 48),
                
                // Stats section
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Text(
                            '552',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            l10n.words,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 40,
                        width: 1,
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                      Column(
                        children: [
                          const Text(
                            '7',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            l10n.languages,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: Semantics(
        label: l10n.currentRandomWord(_getAccessibilityText(l10n)),
        child: FloatingActionButton.extended(
          onPressed: _isGenerating ? null : _newRandom,
          tooltip: l10n.generateNewWord,
          backgroundColor: _isGenerating ? Colors.grey : Colors.white,
          foregroundColor: _isGenerating ? Colors.grey[600] : const Color(0xFF6366F1),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          icon: AnimatedRotation(
            turns: _isGenerating ? 1 : 0,
            duration: const Duration(milliseconds: 300),
            child: Icon(
              _isGenerating ? Icons.refresh : Icons.casino,
              size: 28,
            ),
          ),
          label: Text(
            _isGenerating ? l10n.generating : l10n.newWord,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
