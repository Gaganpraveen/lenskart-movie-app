import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constants/api_config.dart';
import '../models/movie.dart';

class MovieService {
  static final instance = MovieService._();
  MovieService._();

  final Map<int, String> _genres = {};

  Future<void> loadGenres() async {
    if (_genres.isNotEmpty) return;
    try {
      final res = await http.get(Uri.parse('${ApiConfig.baseUrl}/genre/movie/list?api_key=${ApiConfig.apiKey}'));
      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        for (var g in data['genres']) {
          _genres[g['id']] = g['name'];
        }
      }
    } catch (_) {}
  }

  String getGenres(List<int> ids) => ids.take(2).map((id) => _genres[id] ?? '').where((s) => s.isNotEmpty).join(', ');

  Future<List<Movie>> getPopular() async {
    await loadGenres();
    final res = await http.get(Uri.parse('${ApiConfig.baseUrl}/movie/popular?api_key=${ApiConfig.apiKey}'));
    if (res.statusCode == 200) {
      return (json.decode(res.body)['results'] as List).map((m) => Movie.fromJson(m)).toList();
    }
    throw Exception('Failed to load movies');
  }

  Future<List<Movie>> search(String query) async {
    if (query.isEmpty) return getPopular();
    final res = await http.get(Uri.parse('${ApiConfig.baseUrl}/search/movie?api_key=${ApiConfig.apiKey}&query=${Uri.encodeComponent(query)}'));
    if (res.statusCode == 200) {
      return (json.decode(res.body)['results'] as List).map((m) => Movie.fromJson(m)).toList();
    }
    throw Exception('Search failed');
  }
}
