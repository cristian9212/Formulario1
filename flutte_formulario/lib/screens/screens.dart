import 'package:flutter/material.dart';
import '../service/api_service.dart';
import '../models/models.dart'; // Asegúrate que aquí esté tu modelo Movie

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({Key? key}) : super(key: key);

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas Populares'),
      ),
      body: FutureBuilder<List<Movie>>(
        future: apiService.fetchMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No se encontraron películas'));
          }

          final movies = snapshot.data!;
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return ListTile(
                leading: const Icon(Icons.movie),
                title: Text(movie.MovieName),
                subtitle: Text('Año: ${movie.MovieYear}'),
                trailing: Text('Duración: ${movie.duration} min'),
              );
            },
          );
        },
      ),
    );
  }
}
