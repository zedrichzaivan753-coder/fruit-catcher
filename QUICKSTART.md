# 🎮 Fruit Catcher - Quick Start Guide

## ⚡ Super Quick Start (30 seconds)

```bash
# Navigate to project
cd "z:\Downloads\jason flutter\memory game"

# Get dependencies
flutter pub get

# Run on Windows
flutter run -d windows
```

## 📱 Platform Quick Commands

### Desktop Platforms
```bash
# Windows (fastest to test)
flutter run -d windows

# macOS
flutter run -d macos

# Linux
flutter run -d linux
```

### Web Browsers (best for quick testing)
```bash
# Chrome
flutter run -d chrome

# Edge
flutter run -d edge

# Firefox (automatic)
flutter run -d firefox
```

### Mobile Devices
```bash
# Android (requires emulator or device)
flutter run -d android

# iOS (requires macOS)
flutter run -d ios
```

## 🕹️ Playing the Game

| Platform | Control | Action |
|----------|---------|--------|
| **Windows** | Click & Drag | Move basket left/right |
| **Web** | Click & Drag | Move basket left/right |
| **Mobile** | Touch & Drag | Move basket left/right |
| **All** | Catch falling fruits | Score points |

## 📊 Scoring

- **Points per fruit** = 10 × Current Level
- **Level up every** 100 points
- **Higher levels** = Faster fruits + Faster spawning
- **No penalty** for missing fruits

## 🎯 Level Progression

```
Level 1  → Score 0-99   (2.0s spawn, 200 px/s)
Level 2  → Score 100+   (1.85s spawn, 250 px/s)
Level 3  → Score 200+   (1.7s spawn, 300 px/s)
Level 4+ → Progressive   (Faster & Faster)
```

## ✅ Platform Status

| Platform | Status | Command |
|----------|--------|---------|
| Windows | ✅ Working | `flutter run -d windows` |
| Chrome | ✅ Working | `flutter run -d chrome` |
| Edge | ✅ Working | `flutter run -d edge` |
| macOS | ✅ Ready | `flutter run -d macos` |
| Linux | ✅ Ready | `flutter run -d linux` |
| Android | 📦 Setup | `flutter run -d android` |
| iOS | 📦 Setup | `flutter run -d ios` |

## 🔍 Check Available Devices

```bash
flutter devices
```

## 🆘 Need Help?

**Game won't run?**
```bash
flutter clean
flutter pub get
flutter run -d windows
```

**Check requirements:**
```bash
flutter doctor
```

**Hot reload while running:**
- Press `r` in terminal for hot reload
- Press `R` for full restart
- Press `q` to quit

## 🚀 Build for Distribution

### Windows Executable
```bash
flutter build windows --release
```

### Web (deploy anywhere)
```bash
flutter build web --release
```

### Android APK
```bash
flutter build apk --release
```

---

**Ready to play?** Run `flutter run -d windows` and start catching fruits! 🍎🎯
