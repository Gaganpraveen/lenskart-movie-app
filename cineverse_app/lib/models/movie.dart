class Movie {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final double voteAverage;
  final String? releaseDate;
  final List<int> genreIds;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    required this.voteAverage,
    this.releaseDate,
    required this.genreIds,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    id: json['id'] ?? 0,
    title: json['title'] ?? '',
    overview: json['overview'] ?? '',
    posterPath: json['poster_path'],
    backdropPath: json['backdrop_path'],
    voteAverage: (json['vote_average'] ?? 0).toDouble(),
    releaseDate: json['release_date'],
    genreIds: List<int>.from(json['genre_ids'] ?? []),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'overview': overview,
    'poster_path': posterPath,
    'backdrop_path': backdropPath,
    'vote_average': voteAverage,
    'release_date': releaseDate,
    'genre_ids': genreIds,
  };

  String get year => releaseDate?.split('-').first ?? 'N/A';
  int get ratingPercent => (voteAverage * 10).round();
}

class Genre {
  final int id;
  final String name;
  Genre({required this.id, required this.name});
  factory Genre.fromJson(Map<String, dynamic> json) => Genre(id: json['id'], name: json['name']);
}
