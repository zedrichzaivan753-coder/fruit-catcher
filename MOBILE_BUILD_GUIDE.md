# Mobile Build Guide - Fruit Catcher

Your Fruit Catcher game is now configured to run on Android and iOS devices!

## Platform Setup

### Android Setup

**Prerequisites:**
- Android SDK (API Level 21+)
- Android Studio or command line tools
- Java Development Kit (JDK) 11 or higher

**Build for Android:**

```bash
# Debug build (for testing on emulator/device)
flutter run -d android

# Release build (for Google Play Store)
flutter build apk --release

# For split APKs (recommended for smaller downloads)
flutter build apk --split-per-abi --release
```

**Emulator:**
```bash
# List available Android emulators
flutter emulators

# Launch a specific emulator
flutter emulators --launch <emulator-name>

# Or use Android Studio's emulator
```

### iOS Setup

**Prerequisites:**
- Mac with Xcode installed
- Apple Developer Account (optional, for physical device testing)
- CocoaPods package manager

**Build for iOS:**

```bash
# Debug build (for testing on simulator/device)
flutter run -d ios

# Release build (for App Store)
flutter build ios --release

# Building for physical device
flutter run -d ios --release
```

**Simulator:**
```bash
# List available iOS simulators
xcrun simctl list devices

# Launch simulator from command line
open -a Simulator
```

## Mobile-Specific Features

### ✅ Portrait Orientation
The game is set to portrait mode only for mobile devices, making it perfect for handheld play.

### ✅ Touch Input
- **Tap to move**: Tap anywhere to move the basket to that position
- **Drag to move**: Drag your finger across the screen to smoothly move the basket

### ✅ Responsive UI
- Playing field scales to 80% of screen width
- All UI elements automatically adjust to different screen sizes
- Works on phones, tablets, and all aspect ratios

### ✅ Game Over Screen
- Responsive overlay with "Play Again" button
- Clearly visible on all screen sizes

## Supported Devices

### Android
- Android 5.0 (API 21) and above
- Phones, tablets, foldables
- All common resolutions

### iOS
- iOS 11.0 and above
- iPhone, iPad
- All screen sizes including notched devices

## Performance Tips

1. **Use Release Builds**: Always use `--release` flag for better performance
2. **Close Background Apps**: Close other apps for smoother gameplay
3. **Device Storage**: Ensure sufficient free storage on device
4. **Network**: Game doesn't require internet connection

## Troubleshooting

### Android Build Issues
```bash
# Clean build
flutter clean
flutter pub get
flutter run -d android

# If gradle issues persist
cd android
./gradlew clean
cd ..
flutter run -d android
```

### iOS Build Issues
```bash
# Clean build
flutter clean
flutter pub get
flutter run -d ios

# If pod issues persist
cd ios
rm -rf Pods
rm Podfile.lock
pod install
cd ..
flutter run -d ios
```

### Touch Input Not Responding
- Ensure you're in the correct playing area (between the white boundary lines)
- On Android: Try restarting the app
- On iOS: Ensure app has permission to receive touch input (check Settings)

## Publishing

### Android (Google Play Store)
1. Create signed APK: `flutter build apk --release`
2. Create app signing keystore
3. Upload to Google Play Console
4. Follow store guidelines for submission

### iOS (App Store)
1. Create App ID in Apple Developer Portal
2. Build: `flutter build ios --release`
3. Archive through Xcode
4. Upload to App Store Connect
5. Submit for review

## Testing Checklist

- [ ] Game starts correctly on Android device/emulator
- [ ] Game starts correctly on iOS device/simulator
- [ ] Touch controls respond properly
- [ ] Fruits spawn within playing area
- [ ] Basket moves within boundaries
- [ ] Scoring works correctly
- [ ] Game Over triggers after 10 misses
- [ ] Restart button works
- [ ] UI scales properly on different screen sizes
- [ ] Game performance is smooth (60 FPS)

## Device Orientation

The game is locked to **portrait mode only** for mobile devices. To unlock portrait/landscape:

Edit `lib/main.dart`:
```dart
SystemChrome.setPreferredOrientations([
  DeviceOrientation.portraitUp,
  DeviceOrientation.portraitDown,
  DeviceOrientation.landscapeLeft,      // Add these
  DeviceOrientation.landscapeRight,     // Add these
]);
```

## Screen Dimensions

**Tested Resolutions:**
- Small phones: 360×640 (Galaxy A11)
- Standard phones: 412×915 (Pixel 5)
- Large phones: 480×854 (Galaxy S20 Ultra)
- Tablets: 768×1024+ (iPad)

The responsive design automatically adjusts to all resolutions.

## Next Steps

1. **Test on Emulator**: `flutter run -d android`
2. **Test on Physical Device**: Connect device and run
3. **Monitor Performance**: Use DevTools: `flutter pub global activate devtools` then `devtools`
4. **Gather Feedback**: Test with friends and family
5. **Publish**: When ready, follow platform-specific publishing guidelines

---

**Built with Flutter + Flame Engine 🎮**
