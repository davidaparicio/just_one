# 🎲 Just One

A multilingual Flutter mobile app for the popular party game "Just One" - a cooperative word-guessing game that brings friends and family together for fun and laughter!

## 📱 About the Game

Just One is a cooperative party game where players work together to help one player guess mystery words by writing secret clues. The challenge? All identical clues get canceled out, so creativity and originality are key!

### How to Play
1. One player becomes the active player and closes their eyes
2. Everyone else secretly writes a one-word clue on their board
3. Remove all duplicate clues before showing them
4. The active player tries to guess the mystery word using the remaining unique clues
5. Score points based on successful guesses!

## ✨ Features

- 🌍 **7 Languages Support**: English, Spanish, French, Italian, Portuguese, Chinese, and Japanese
- 🎯 **552+ Words**: Extensive word database for endless gameplay
- 🎨 **Beautiful UI**: Modern, gradient-based design with smooth animations
- 📱 **Cross-Platform**: Runs on iOS, Android, Web, Windows, macOS, and Linux
- 🔄 **Random Generation**: Smart word randomization for fair gameplay
- 📖 **Game Rules**: Built-in multilingual rules explanation
- 🌐 **Auto Language Detection**: Automatically detects device language
- ♿ **Accessibility**: Full screen reader support and semantic labeling

## 🛠️ Technical Stack

- **Framework**: Flutter 3.9+
- **Language**: Dart
- **Platforms**: iOS, Android, Web, Windows, macOS, Linux
- **Architecture**: Single-page application with StatefulWidget
- **Localization**: Embedded asset-based translations
- **UI**: Material Design 3 with custom theming

## 📦 Installation

### Prerequisites
- Flutter SDK 3.9.0 or higher
- Dart SDK
- Platform-specific setup (iOS: Xcode, Android: Android Studio)

### Quick Start
```bash
# Clone the repository
git clone https://github.com/davidaparicio/just_one.git
cd just_one

# Install dependencies
flutter pub get

# Run on your preferred platform
flutter run
```

### Platform-Specific Commands
```bash
# iOS
flutter run -d ios

# Android
flutter run -d android

# Web
flutter run -d web

# Windows
flutter run -d windows

# macOS
flutter run -d macos

# Linux
flutter run -d linux
```

## 🌍 Supported Languages

| Language   | Flag | Words | Status     |
|------------|------|-------|------------|
| English    | 🇺🇸 | 552+  | ✅ Complete |
| Spanish    | 🇪🇸 | 552+  | ✅ Complete |
| French     | 🇫🇷 | 552+  | ✅ Complete |
| Italian    | 🇮🇹 | 552+  | ✅ Complete |
| Portuguese | 🇵🇹 | 552+  | ✅ Complete |
| Chinese    | 🇨🇳 | 552+  | ✅ Complete |
| Japanese   | 🇯🇵 | 552+  | ✅ Complete |

## 📁 Project Structure

```
lib/
├── main.dart              # Main app entry point
├── l10n/                  # Localization files (future expansion)
assets/
├── images/
│   ├── background.jpg     # App background
│   └── dice.png          # Dice icon
├── chinese.txt           # Chinese word database
├── english.txt           # English word database
├── french.txt            # French word database
├── italian.txt           # Italian word database
├── japanese.txt          # Japanese word database
├── portuguese.txt        # Portuguese word database
└── spanish.txt           # Spanish word database
```

## 🎮 Game Features

### Word Generation
- **Random Selection**: True randomization from language-specific databases
- **No Repetition Prevention**: Words can repeat to maintain game spontaneity
- **Loading States**: Smooth loading animations during word generation

### User Interface
- **Responsive Design**: Adapts to phone and tablet screen sizes
- **Gradient Theme**: Beautiful purple gradient color scheme
- **Smooth Animations**: Fade and scale transitions for word changes
- **Floating Action Button**: Easy access to generate new words

### Accessibility
- **Screen Reader Support**: Full semantic labeling for visually impaired users
- **High Contrast**: Readable text with proper color contrast ratios
- **Touch Targets**: Appropriately sized interactive elements

## 🔧 Development

### Adding New Languages
1. Create a new word file in `assets/` (e.g., `german.txt`)
2. Add the language to `languageFiles` map in `main.dart`
3. Add display name to `languageNames` map
4. Add game rules translation to `gameRules` map
5. Add UI text translations to `uiTexts` map
6. Update `pubspec.yaml` assets section

### Customizing Words
Edit any language file in the `assets/` directory. Each word should be on a separate line.

### Building for Production
```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release

# Web
flutter build web --release

# Windows
flutter build windows --release

# macOS
flutter build macos --release

# Linux
flutter build linux --release
```

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### Development Guidelines
- Follow Flutter/Dart best practices
- Maintain accessibility standards
- Add tests for new features
- Update documentation as needed

## 🐛 Issues

Found a bug or have a feature request? Please open an issue on GitHub.

## 🙏 Acknowledgments

- Inspired by the original "Just One" board game
- Flutter team for the amazing framework
- Contributors who help improve the word databases
- The open source community

---

**Enjoy playing Just One!** 🎉
->[2022 Flutter Android version](https://github.com/davidaparicio/just-one_2022)