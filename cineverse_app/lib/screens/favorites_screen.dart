import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import '../widgets/movie_card.dart';
import 'movie_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});
  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final movies = StorageService.instance.favorites;
    return Scaffold(
      appBar: AppBar(title: const Text('Favourites', style: TextStyle(fontWeight: FontWeight.bold))),
      body: movies.isEmpty
          ? const Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.favorite_outline, size: 48, color: Colors.grey),
              SizedBox(height: 16),
              Text('No favourites yet', style: TextStyle(color: Colors.grey)),
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
