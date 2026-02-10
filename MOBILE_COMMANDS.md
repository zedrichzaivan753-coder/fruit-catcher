# Quick Mobile Commands

## Android

### Run on Emulator
```bash
flutter run -d android
```

### Run on Physical Device
```bash
# Connect device via USB with USB debugging enabled
flutter run -d android
```

### Build APK
```bash
flutter build apk --release
```

## iOS

### Run on Simulator
```bash
flutter run -d ios
```

### Run on Physical Device (Mac required)
```bash
flutter run -d ios
```

### Build for App Store
```bash
flutter build ios --release
```

## General

### See Available Devices
```bash
flutter devices
```

### List Emulators/Simulators
```bash
flutter emulators
```

### Launch Specific Device
```bash
flutter run -d <device-id>
```

### Hot Reload While Running
```
Press 'r' in terminal
```

### Hot Restart While Running
```
Press 'R' in terminal
```

---

**The game automatically supports both platforms with the same codebase!**
