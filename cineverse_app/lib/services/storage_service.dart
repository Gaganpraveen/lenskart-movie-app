import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/movie.dart';

class StorageService {
  static final instance = StorageService._();
  StorageService._();

  List<Movie> _favorites = [];
  List<Movie> _watchlist = [];

  List<Movie> get favorites => _favorites;
  List<Movie> get watchlist => _watchlist;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _favorites = _load(prefs, 'favorites');
    _watchlist = _load(prefs, 'watchlist');
  }

  List<Movie> _load(SharedPreferences prefs, String key) {
    final str = prefs.getString(key);
    if (str == null) return [];
    return (json.decode(str) as List).map((m) => Movie.fromJson(m)).toList();
  }

  Future<void> _save(String key, List<Movie> list) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, json.encode(list.map((m) => m.toJson()).toList()));
  }

  bool isFavorite(int id) => _favorites.any((m) => m.id == id);
  bool inWatchlist(int id) => _watchlist.any((m) => m.id == id);

  Future<void> toggleFavorite(Movie movie) async {
    isFavorite(movie.id) ? _favorites.removeWhere((m) => m.id == movie.id) : _favorites.insert(0, movie);
    await _save('favorites', _favorites);
  }

  Future<void> toggleWatchlist(Movie movie) async {
    inWatchlist(movie.id) ? _watchlist.removeWhere((m) => m.id == movie.id) : _watchlist.insert(0, movie);
    await _save('watchlist', _watchlist);
  }
}
