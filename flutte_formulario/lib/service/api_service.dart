import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/models.dart';

class ApiService {
  final String apiKey = '9515420ddf6df436122f316db2946e0d';
  final String baseUrl = 'https://api.themoviedb.org/3';

  Future<List<Movie>> fetchMovies() async {
    final url = Uri.parse('$baseUrl/movie/popular?api_key=$apiKey&language=es-ES&page=1');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List<dynamic> results = jsonResponse['results'];

      return results.map((item) => Movie.fromJsonTMDB(item)).toList();
    } else {
      throw Exception('Error al cargar las películas populares');
    }
  }
}
