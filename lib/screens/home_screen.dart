import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../widgets/movie_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w800),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: GoogleFonts.montserrat(),
                suffixIcon: Icon(Icons.outlined_flag),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              onChanged: (value) {
                context.read<MovieProvider>().searchMovies(value);
              },
            ),
          ),
          Expanded(
            child: Consumer<MovieProvider>(
              builder: (context, movieProvider, child) {
                if (movieProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (movieProvider.error.isNotEmpty) {
                  return Center(
                    child: Text(
                      movieProvider.error,
                      style: GoogleFonts.montserrat(),
                    ),
                  );
                }

                if (movieProvider.movies.isEmpty) {
                  return Center(
                    child: Text(
                      'Search for Movies',
                      style: GoogleFonts.montserrat(),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: movieProvider.movies.length,
                  itemBuilder: (context, index) {
                    return MovieCard(movie: movieProvider.movies[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
