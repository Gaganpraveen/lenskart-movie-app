import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../core/constants/api_config.dart';
import '../models/movie.dart';
import '../services/movie_service.dart';
import '../services/storage_service.dart';
import '../services/notification_service.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;
  const MovieDetailScreen({super.key, required this.movie});
  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  Movie get movie => widget.movie;

  Color _ratingColor(double rating) {
    if (rating >= 7) return Colors.green;
    if (rating >= 5) return Colors.yellow.shade700;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final storage = StorageService.instance;
    final genres = MovieService.instance.getGenres(movie.genreIds);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: ApiConfig.backdropUrl(movie.backdropPath),
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(color: const Color(0xFF1A1A1A)),
                    errorWidget: (_, __, ___) => Container(color: const Color(0xFF1A1A1A), child: const Icon(Icons.movie, size: 64)),
                  ),
                  Container(decoration: BoxDecoration(gradient: LinearGradient(
                    begin: Alignment.topCenter, end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                  ))),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(storage.isFavorite(movie.id) ? Icons.favorite : Icons.favorite_outline,
                    color: storage.isFavorite(movie.id) ? Colors.red : null),
                onPressed: () async { await storage.toggleFavorite(movie); setState(() {}); },
              ),
              IconButton(
                icon: Icon(storage.inWatchlist(movie.id) ? Icons.bookmark : Icons.bookmark_outline,
                    color: storage.inWatchlist(movie.id) ? Colors.amber : null),
                onPressed: () async { await storage.toggleWatchlist(movie); setState(() {}); },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  if (genres.isNotEmpty) ...[
                    Wrap(
                      spacing: 8,
                      children: genres.split(', ').map((g) => Chip(
                        label: Text(g, style: const TextStyle(fontSize: 12)),
                        backgroundColor: Colors.red.shade700.withOpacity(0.2),
                        side: BorderSide.none,
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                      )).toList(),
                    ),
                    const SizedBox(height: 12),
                  ],
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(movie.releaseDate ?? 'N/A', style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      CircularPercentIndicator(
                        radius: 35,
                        lineWidth: 6,
                        percent: movie.voteAverage / 10,
                        center: Text('${movie.ratingPercent}%', style: const TextStyle(fontWeight: FontWeight.bold)),
                        progressColor: _ratingColor(movie.voteAverage),
                        backgroundColor: Colors.grey.shade800,
                        circularStrokeCap: CircularStrokeCap.round,
                      ),
                      const SizedBox(width: 16),
                      const Text('User Score', style: TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text('Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(movie.overview.isEmpty ? 'No overview available.' : movie.overview,
                      style: const TextStyle(color: Colors.grey, height: 1.5)),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await NotificationService.instance.showPlaying(movie.title);
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${movie.title} is Playing'), backgroundColor: Colors.red.shade700),
                          );
                        }
                      },
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Play Now'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade700,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
