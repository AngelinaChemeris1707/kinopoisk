import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'movie.dart';

part 'movies_notifier.g.dart';

@riverpod
class MoviesNotifier extends _$MoviesNotifier {
  List<Movie> get movies => () {
        //название геттера - это поле, которое он возвращает?
        if (_query == "") {
          return _movies;
        } else {
          return _movies
              .where((movie) =>
                  movie.name.toLowerCase().contains(_query.toLowerCase()))
              .toList();
        }
      }();

  final List<Movie> _movies = [];
  String _query = "";

  @override
  List<Movie> build() {
    return movies;
  }

  void add({required Movie movie}) {
    _movies.add(movie);
    ref.notifyListeners();
  }

  void updateQuery(String query) {
    _query = query;
    ref.notifyListeners();
  }

  void remove({required int movieIndex}) {}

  void replace({required Movie oldMovie, required Movie newMovie}) {
    final index = _movies.indexOf(oldMovie);
    if (index == -1) {
      return;
    }
    _movies[index] = newMovie;
    ref.notifyListeners();
  }
}
