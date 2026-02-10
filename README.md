# 🎮 Fruit Catcher - Mini Arcade Game

A fun, interactive arcade game built with Flutter and Flame Engine. Catch the falling fruits to earn points and progress through increasing difficulty levels!

## 🎯 Features

### Core Gameplay
- **Catch the Falling Fruits**: Use your basket to catch emoji fruits (🍎🍌🍊🍇🍓) falling from the top
- **Drag & Tap Controls**: Move your basket left and right to catch fruits
- **Real-time Scoring**: Earn 10 × level points for each fruit caught

### Difficulty System
- **Progressive Levels**: Level up every 100 points
- **Increasing Spawn Rate**: Fruits spawn faster as you progress
- **Increasing Speed**: Fruits fall faster with each level
- **Dynamic Challenge**: Game becomes progressively harder to keep you engaged

### UI & Scoreboard
- **Live Score Display**: Track your current score in real-time
- **Level Indicator**: See which level you're playing
- **Spawn Rate Monitor**: Watch the spawn rate decrease (faster spawning)
- **Clean Interface**: Minimalist design focused on gameplay

## 📱 Platform Support

This game runs on **multiple platforms**:

### Desktop ✅ Working
- **Windows**: Native desktop application
- **macOS**: Mac application support available
- **Linux**: Linux application support available

### Web ✅ Working
- **Chrome**: Full support
- **Edge**: Full support
- **Firefox**: Compatible
- **Safari**: Compatible

### Mobile 📦 Setup Available
- **Android**: Ready to deploy (configure with Android Studio)
- **iOS**: Ready to deploy (configure with Xcode)

## 🚀 Running the Game

### Windows (Desktop)
```bash
flutter run -d windows
```

### Web (Chrome)
```bash
flutter run -d chrome
```

### Web (Edge)
```bash
flutter run -d edge
```

### Android (Mobile)
```bash
flutter run -d android
```
*Requires Android emulator or physical device connected*

### iOS (Mobile)
```bash
flutter run -d ios
```
*Requires macOS and Xcode*

### Linux
```bash
flutter run -d linux
```

### macOS
```bash
flutter run -d macos
```

## 🕹️ How to Play

1. **Start the Game**: Launch on your preferred platform
2. **Move the Basket**: 
   - **Desktop**: Click and drag the basket, or tap to move
   - **Mobile**: Tap and drag your finger to move the basket
   - **Web**: Click and drag on your mouse or tap on touch screen
3. **Catch Fruits**: Position your basket to catch falling fruits
4. **Earn Points**: Each caught fruit = 10 × current level points
5. **Level Up**: Every 100 points = new level with faster fruits
6. **Challenge**: Beat your high score!

## 📊 Game Mechanics

### Difficulty Progression
| Level | Spawn Rate | Fall Speed | Points/Fruit |
|-------|-----------|-----------|-------------|
| 1 | 2.0s | 200 px/s | 10 |
| 2 | 1.85s | 250 px/s | 20 |
| 3 | 1.7s | 300 px/s | 30 |
| 4+ | Progressive | Progressive | Level × 10 |

## 🏗️ Project Structure

```
lib/
├── main.dart                      # App entry point
├── fruit_catcher_game.dart        # Main game logic & Flame game
└── components/
    ├── fruit.dart                 # Falling fruit component
    └── basket.dart                # Player basket component
```

## 📦 Installation

1. **Navigate to project folder**
   ```bash
   cd "z:\Downloads\jason flutter\memory game"
   ```

2. **Get dependencies**
   ```bash
   flutter pub get
   ```

3. **Check available devices**
   ```bash
   flutter devices
   ```

4. **Run on desired platform**
   ```bash
   flutter run -d <device_name>
   ```

## ⚙️ Technical Stack

- **Framework**: Flutter 3.0+
- **Game Engine**: Flame 1.10+
- **Language**: Dart
- **UI**: Flutter Material Design
- **Graphics**: Canvas rendering

## 🔧 Building for Release

### Windows Executable
```bash
flutter build windows --release
```
Find executable: `build/windows/x64/runner/Release/fruit_catcher.exe`

### Web Build
```bash
flutter build web --release
```
Deploy the `build/web` folder to any web server

### Android APK
```bash
flutter build apk --release
```

### iOS App
```bash
flutter build ios --release
```

## 🎮 Game Features in Detail

### Scoring
- **10 points base** × **current level** per fruit
- Level increases every **100 points**
- No penalty for missed fruits

### Fruit Types
🍎 Apple | 🍌 Banana | 🍊 Orange | 🍇 Grape | 🍓 Strawberry

### Difficulty Scaling
```
Spawn Rate = max(0.5s, 2.0 - (level × 0.15))
Fall Speed = 200 + (level × 50) pixels/second
```

## 🐛 Troubleshooting

### Game won't run
```bash
flutter clean
flutter pub get
flutter run -d windows
```

### Platform not available
```bash
flutter doctor
flutter devices
```

### Performance issues
- Run in release mode: `flutter run -r -d windows`
- Close other applications
- Try a different platform

## 📚 Resources

- [Flame Engine Docs](https://flame-engine.org/)
- [Flutter Docs](https://flutter.dev/)
- [Dart Docs](https://dart.dev/)

## 🎓 Have Fun!

Enjoy Fruit Catcher across all your devices! Challenge yourself to reach higher levels and beat your high score.

**Happy Catching!** 🍎🎯

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## FOR TRANSFER

# Copy entire project folder
Copy-Item -Recurse "z:\Downloads\jason flutter\memory game" "C:\NewLocation\my-game"

cd "C:\NewLocation\my-game"
flutter clean
flutter pub get
flutter run -d windows

Option 2: Clone from Git (If versioned)
git clone <repository-url> <new-location>
cd <new-location>
flutter pub get

## Renaming STEPS
1. Rename the Folder
Rename-Item "C:\Games\memory game" "C:\Games\my-awesome-game"
cd "C:\Games\my-awesome-game"

2. name: my_awesome_game  # Changed from fruit_catcher
description: Catch the Falling Fruits game

3. <application
    android:label="My Awesome Game"  <!-- Changed from fruit_catcher -->
    ...

    android {
    namespace "com.example.my_awesome_game"  // Update namespace
    ...
}

