import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinopoisk_angelina/screens/detail_screen.dart';
import 'package:kinopoisk_angelina/widgets/movie_list.dart';
import '../state/movies_notifier.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final movies = ref.watch(
        moviesNotifierProvider); //Тут мы получаем список фильмов. Состояние - это и есть список фильмов.
    final notifier = ref.read(moviesNotifierProvider.notifier); //

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Мой Кинопоиск'),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: MySearchDelegate(notifier: notifier),
                  );
                },
                icon: const Icon(Icons.search, color: Colors.white))
          ],
          backgroundColor: Colors.brown,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
        ),
        body: MovieList(
          movies: movies,
          onMovieSelected: (movieIndex) {
            final movie = movies[movieIndex];
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DetailScreen(movie: movie)));
          },
          onMovieDeleted: (movie) {
            notifier.remove(movie: movie);
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const DetailScreen(movie: null)));
            },
            label: const Text("Добавить фильм")));
  }
}

class MySearchDelegate extends SearchDelegate {
  final MoviesNotifier notifier;

  MySearchDelegate({required this.notifier});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final movies = notifier.movies;
    if (movies.isEmpty) {
      return const Center(child: Text("Ничего не найдено"));
    }
    return MovieList(
      movies: notifier.movies,
      onMovieSelected: (movieIndex) {
        final movie = movies[movieIndex];
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailScreen(movie: movie)));
      },
      onMovieDeleted: (movie) {
        notifier.remove(movie: movie);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Future(
      () {
        notifier.updateQuery(query);
      },
    );
    return Container(
      color: Colors.white,
    );
  }
}
