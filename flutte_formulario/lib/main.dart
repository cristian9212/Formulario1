import 'package:flutter/material.dart';
import 'models/models.dart';
import 'service/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ApiService apiService = ApiService();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cars Movies Inventory',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MovieScreen(),
    );
  }
}

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies Inventory'),
      ),
      body: FutureBuilder<List<Movie>>(
        future: apiService.fetchMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No car movies found.'));
          } else {
            List<Movie> Movies = snapshot.data!;
            return ListView.builder(
              itemCount: Movies.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(Movies[index].MovieName),
                  subtitle: Text('Year: ${Movies[index].MovieYear}, Duration: ${Movies[index].duration} min'),
                );
              },
            );
          }
        },
      ),
    );
  }
}