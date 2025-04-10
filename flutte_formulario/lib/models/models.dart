class Movie {
  final String id;
  final String MovieName;
  final int MovieYear;
  final int duration;

  Movie({
    required this.id,
    required this.MovieName,
    required this.MovieYear,
    required this.duration,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'].toString(),
      MovieName: json['MovieName'],
      MovieYear: int.tryParse(json['MovieYear'].toString()) ?? 0,
      duration: int.tryParse(json['duration'].toString()) ?? 0,
    );
  }

  // Nuevo constructor adaptado a TMDB
  factory Movie.fromJsonTMDB(Map<String, dynamic> json) {
    return Movie(
      id: json['id'].toString(),
      MovieName: json['title'] ?? 'Sin título',
      MovieYear: DateTime.tryParse(json['release_date'] ?? '')?.year ?? 0,
      duration: 0, // TMDB no lo da aquí, lo dejamos en 0 o puedes consultar detalle por ID
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'MovieName': MovieName,
      'MovieYear': MovieYear,
      'duration': duration,
    };
  }
}
