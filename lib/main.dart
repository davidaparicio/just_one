import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

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
      home: const MyHomePage(title: '🎲 Just One'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

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
  
  final Map<String, Map<String, String>> uiTexts = {
    'english': {
      'tapDice': 'Tap dice for new word',
      'words': 'Words',
      'languages': 'Languages',
      'newWord': 'New Word',
      'generating': 'Generating...',
      'gameRules': 'Game Rules',
      'gotIt': 'Got it! 👍',
      'randomWordGenerator': 'Random Word Generator',
      'tapTheDice': 'Tap the dice!',
      'loading': 'Loading...',
      'generateNewWord': 'Generate a new random word',
    },
    'spanish': {
      'tapDice': 'Toca el dado para nueva palabra',
      'words': 'Palabras',
      'languages': 'Idiomas',
      'newWord': 'Nueva Palabra',
      'generating': 'Generando...',
      'gameRules': 'Reglas del Juego',
      'gotIt': '¡Entendido! 👍',
      'randomWordGenerator': 'Generador de Palabras Aleatorias',
      'tapTheDice': '¡Toca el dado!',
      'loading': 'Cargando...',
      'generateNewWord': 'Genera una nueva palabra aleatoria',
    },
    'italian': {
      'tapDice': 'Tocca il dado per nuova parola',
      'words': 'Parole',
      'languages': 'Lingue',
      'newWord': 'Nuova Parola',
      'generating': 'Generazione...',
      'gameRules': 'Regole del Gioco',
      'gotIt': 'Capito! 👍',
      'randomWordGenerator': 'Generatore di Parole Casuali',
      'tapTheDice': 'Tocca il dado!',
      'loading': 'Caricamento...',
      'generateNewWord': 'Genera una nuova parola casuale',
    },
    'portuguese': {
      'tapDice': 'Toque no dado para nova palavra',
      'words': 'Palavras',
      'languages': 'Idiomas',
      'newWord': 'Nova Palavra',
      'generating': 'Gerando...',
      'gameRules': 'Regras do Jogo',
      'gotIt': 'Entendi! 👍',
      'randomWordGenerator': 'Gerador de Palavras Aleatórias',
      'tapTheDice': 'Toque no dado!',
      'loading': 'Carregando...',
      'generateNewWord': 'Gera uma nova palavra aleatória',
    },
    'chinese': {
      'tapDice': '点击骰子生成新词',
      'words': '词汇',
      'languages': '语言',
      'newWord': '新词汇',
      'generating': '生成中...',
      'gameRules': '游戏规则',
      'gotIt': '明白了! 👍',
      'randomWordGenerator': '随机词汇生成器',
      'tapTheDice': '点击骰子!',
      'loading': '加载中...',
      'generateNewWord': '生成一个新的随机词汇',
    },
    'japanese': {
      'tapDice': 'サイコロをタップして新しい単語',
      'words': '単語',
      'languages': '言語',
      'newWord': '新しい単語',
      'generating': '生成中...',
      'gameRules': 'ゲームルール',
      'gotIt': '分かりました! 👍',
      'randomWordGenerator': 'ランダム単語ジェネレーター',
      'tapTheDice': 'サイコロをタップ!',
      'loading': '読み込み中...',
      'generateNewWord': '新しいランダムな単語を生成',
    },
    'french': {
      'tapDice': 'Touchez le dé pour un nouveau mot',
      'words': 'Mots',
      'languages': 'Langues',
      'newWord': 'Nouveau Mot',
      'generating': 'Génération...',
      'gameRules': 'Règles du Jeu',
      'gotIt': 'Compris! 👍',
      'randomWordGenerator': 'Générateur de Mots Aléatoires',
      'tapTheDice': 'Touchez le dé!',
      'loading': 'Chargement...',
      'generateNewWord': 'Générer un nouveau mot aléatoire',
    },
  };
  
  String getText(String key) {
    return uiTexts[currentLanguage]?[key] ?? uiTexts['english']![key]!;
  }
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
        _pickWord = getText('loading');
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
      _pickWord = getText('loading');
      _isGenerating = true;
    });
    await readFileAsync('$newLanguage.txt');
    await Future.delayed(const Duration(milliseconds: 500));
    _newRandom();
  }
  
  void _showRulesDialog() {
    final rules = gameRules[currentLanguage] ?? gameRules['english']!;
    
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
                        rules['title']!,
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
                      rules['content']!,
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
                      getText('gotIt'),
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
        _pickWord = getText('tapTheDice');
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
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
            tooltip: getText('gameRules'),
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
            builder: (context, constraints) {
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
                      getText('randomWordGenerator'),
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
                                _pickWord.isEmpty ? getText('tapTheDice') : _pickWord,
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
                            getText('tapDice'),
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
                            getText('words'),
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
                            getText('languages'),
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
        label: getText('generateNewWord'),
        child: FloatingActionButton.extended(
          onPressed: _isGenerating ? null : _newRandom,
          tooltip: getText('generateNewWord'),
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
            _isGenerating ? getText('generating') : getText('newWord'),
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
