import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class MovieProvider with ChangeNotifier {
  List<Movie> _movies = [];
  bool _isLoading = false;
  String _error = '';

  List<Movie> get movies => _movies;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      _movies = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    _error = '';
    notifyListeners();

// I have used the api from the rapidapi.com insted of the official imdb's api

    try {
      final response = await http.get(
        Uri.parse('https://imdb8.p.rapidapi.com/auto-complete?q=$query'),
        headers: {
          'X-RapidAPI-Key':
              '79b5f272bamshdeca3698e6aedb6p1be968jsnbd812da64c03',
          'X-RapidAPI-Host': 'imdb8.p.rapidapi.com',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _movies =
            (data['d'] as List).map((movie) => Movie.fromJson(movie)).toList();
      } else {
        _error = 'Failed to load movies';
      }
    } catch (e) {
      _error = 'Error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
