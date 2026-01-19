class ApiConfig {
  ApiConfig._();

  // ⚠️ IMPORTANT: Replace with your TMDB API key before running
  // Get yours FREE at: https://www.themoviedb.org/settings/api
  static const String apiKey = 'YOUR_TMDB_API_KEY_HERE';

  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBase = 'https://image.tmdb.org/t/p/w500';
  static const String backdropBase = 'https://image.tmdb.org/t/p/w1280';

  static String imageUrl(String? path) => path != null ? '$imageBase$path' : '';
  static String backdropUrl(String? path) => path != null ? '$backdropBase$path' : '';
}
