import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinopoisk_angelina/state/movie.dart';
import 'package:kinopoisk_angelina/widgets/movie_list.dart';
import '../state/movies_notifier.dart';

const List<String> filmNames = <String>['Титаник', 'Девчата'];
const List<int> filmYears = <int>[1999, 1954];

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final movies = ref.watch(moviesNotifierProvider);
    final notifier = ref.read(moviesNotifierProvider.notifier);

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
        body: MovieList(movies: movies),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              ref.read(moviesNotifierProvider.notifier).add(
                  movie: Movie(
                      name: "Летят журавли", year: "1957", country: "СССР"));
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
    return MovieList(movies: notifier.movies);
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

//  AppBar(
//           centerTitle: true,
//           title: const Text('Мой Кинопоиск'),
//           titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
//           actions: <Widget>[
//             IconButton(
//                 onPressed: () {},
//                 icon: const Icon(Icons.search, color: Colors.white))
//           ],
//           backgroundColor: Colors.brown,
//           shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(25),
//                   bottomRight: Radius.circular(25))),
//         ),
