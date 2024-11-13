class Movie {
  final String title;
  final String id;
  final String imageUrl;
  final String category;
  final int rank;
  final String cast;
  final String year;

  Movie({
    required this.title,
    required this.id,
    required this.imageUrl,
    required this.category,
    required this.rank,
    required this.cast,
    required this.year,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['l'] ?? '',
      id: json['id'] ?? '',
      imageUrl: json['i']?['imageUrl'] ?? '',
      category: json['q'] ?? '',
      rank: json['rank'] ?? 0,
      cast: json['s'] ?? '',
      year: json['y']?.toString() ?? '',
    );
  }
}
