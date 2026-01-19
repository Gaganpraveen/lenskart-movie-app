import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import '../widgets/movie_card.dart';
import 'movie_detail_screen.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});
  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  @override
  Widget build(BuildContext context) {
    final movies = StorageService.instance.watchlist;
    return Scaffold(
      appBar: AppBar(title: const Text('Watchlist', style: TextStyle(fontWeight: FontWeight.bold))),
      body: movies.isEmpty
          ? const Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.bookmark_outline, size: 48, color: Colors.grey),
              SizedBox(height: 16),
              Text('Watchlist is empty', style: TextStyle(color: Colors.grey)),
            ]))
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.65, crossAxisSpacing: 12, mainAxisSpacing: 12,
              ),
              itemCount: movies.length,
              itemBuilder: (_, i) => MovieCard(
                movie: movies[i],
                onTap: () async {
                  await Navigator.push(context, MaterialPageRoute(builder: (_) => MovieDetailScreen(movie: movies[i])));
                  setState(() {});
                },
              ),
            ),
    );
  }
}
