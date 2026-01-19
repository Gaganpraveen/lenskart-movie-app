# Quick Setup Guide

## API Key Configuration

**Your TMDB API Key:** `55bde3a6112a911270eb6a8c1c046e13`

### To Run Locally:

1. Open `lib/core/constants/api_config.dart`
2. Replace `YOUR_TMDB_API_KEY_HERE` with:
   ```dart
   static const String apiKey = '55bde3a6112a911270eb6a8c1c046e13';
   ```
3. Run: `flutter pub get && flutter run`

### For GitHub (API Key Masked):
The project is already set up with a placeholder. Push as-is.
Anyone cloning needs their own TMDB API key.

## Quick Commands

```bash
# Install dependencies
flutter pub get

# Run on device/emulator
flutter run

# Build release APK
flutter build apk --release
```

APK location: `build/app/outputs/flutter-apk/app-release.apk`
