import 'package:flutter/material.dart';
import 'movie_list_item.dart';
import '../data/movie.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;
  final Function(int) onMovieSelected;
  final Function(Movie) onMovieDeleted;

  const MovieList(
      {super.key,
      required this.movies,
      required this.onMovieSelected,
      required this.onMovieDeleted});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: movies.length,
        itemExtent: 110,
        itemBuilder: (BuildContext context, int index) {
          final movie = movies[index];
          return Dismissible(
              confirmDismiss: (direction) async {
                onMovieDeleted(movie);
                return true;
              },
              direction: DismissDirection.endToStart,
              background: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 80,
                color: Colors.red,
                margin: const EdgeInsets.all(11),
                alignment: Alignment.centerRight,
                child: const Icon(Icons.delete_forever_rounded),
              ),
              key: ValueKey<int>(index),
              child: GestureDetector(
                onTap: () => onMovieSelected(index),
                child: MovieListItem(
                  movieTitle: movie.name,
                  movieDate: movie.year,
                  movieCountry: movie.country,
                ),
              ));
        });
  }
}
