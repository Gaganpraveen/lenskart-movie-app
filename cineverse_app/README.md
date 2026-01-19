# Cineverse 🎬

A clean, production-ready movie discovery app built with Flutter, powered by TMDB API.

## Features

- **Browse Movies** - Popular movies grid with poster, name, and genre
- **Search** - Real-time search using TMDB search API
- **Favourites** - Save movies to your favourites list
- **Watchlist** - Add movies to watch later
- **Movie Details** - Banner, overview, release date, genre, circular rating indicator
- **Play Now** - In-app notification when "Play Now" is tapped

## Screenshots

| Movies | Detail | Favourites |
|--------|--------|------------|
| Grid view with search | Full movie info | Saved movies |

## Tech Stack

- Flutter 3.x
- Dart
- TMDB API v3
- SharedPreferences (local storage)
- flutter_local_notifications

## Project Structure

```
lib/
├── main.dart
├── core/constants/
│   └── api_config.dart      # API configuration
├── models/
│   └── movie.dart           # Data models
├── services/
│   ├── movie_service.dart   # TMDB API calls
│   ├── storage_service.dart # Local persistence
│   └── notification_service.dart
├── screens/
│   ├── splash_screen.dart
│   ├── home_screen.dart
│   ├── movies_screen.dart
│   ├── favorites_screen.dart
│   ├── watchlist_screen.dart
│   └── movie_detail_screen.dart
└── widgets/
    └── movie_card.dart
```

## Setup

### Prerequisites

- Flutter SDK 3.0+
- Android Studio / VS Code
- TMDB API Key ([Get one here](https://www.themoviedb.org/settings/api))

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/cineverse.git
   cd cineverse
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure API Key**
   
   Open `lib/core/constants/api_config.dart` and add your TMDB API key:
   ```dart
   static const String apiKey = 'YOUR_TMDB_API_KEY';
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Build APK

```bash
flutter build apk --release
```

APK will be at: `build/app/outputs/flutter-apk/app-release.apk`

## Assumptions

- No user authentication required - all data is stored locally
- Single user device - favourites/watchlist stored in SharedPreferences
- Android-focused (iOS compatible but not tested)
- Internet connection required for movie data

## API Reference

- Base URL: `https://api.themoviedb.org/3`
- [TMDB API Documentation](https://developers.themoviedb.org/3)

## States Handled

- ✅ Loading state (spinner)
- ✅ Empty state (placeholder message)
- ✅ Error state (retry button)

## License

MIT
