import 'package:flutter/material.dart';
import 'movie_list_item.dart';
import '../state/movie.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;
  const MovieList({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: movies.length,
        itemExtent: 110,
        itemBuilder: (BuildContext context, int index) {
          final movie = movies[index];
          return Dismissible(
              background: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 80,
                color: Colors.red,
                margin: const EdgeInsets.all(11),
                alignment: Alignment.centerRight,
                child: const Icon(Icons.delete_forever_rounded),
              ),
              key: ValueKey<int>(index),
              child: MovieListItem(
                movieTitle: movie.name,
                movieDate: movie.year,
                movieCountry: movie.country,
              ));
        });
  }
}
