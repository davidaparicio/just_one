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
                      'Random Word Generator',
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
                                _pickWord.isEmpty ? "Tap the dice!" : _pickWord,
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
                            'Tap dice for new word',
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
                          const Text(
                            'Words',
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
                          const Text(
                            'Languages',
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
        label: 'Generate a new random word',
        child: FloatingActionButton.extended(
          onPressed: _isGenerating ? null : _newRandom,
          tooltip: 'Generate New Word',
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
            _isGenerating ? 'Generating...' : 'New Word',
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
