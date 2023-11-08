import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/movie.dart';
import '../data/object_box.dart';
import '../objectbox.g.dart';

part 'movies_notifier.g.dart';

@riverpod
class MoviesNotifier extends _$MoviesNotifier {
  late final _box = objectbox.store.box<Movie>();

  List<Movie> get movies => () {
        if (_query == "") {
          return _box.getAll();
        } else {
          final query =
              _box.query(Movie_.name.contains(_query.toLowerCase())).build();
          final results = query.find();
          query.close();
          return results;
        }
      }();

  String _query = "";

  @override
  List<Movie> build() {
    return movies;
  }

  void add({required Movie movie}) {
    _box.put(movie);
    ref.invalidateSelf();
  }

  void updateQuery(String query) {
    _query = query;
    ref.invalidateSelf();
  }

  void remove({required Movie movie}) {
    _box.remove(movie.id);
    ref.invalidateSelf();
  }

  void replace({required Movie oldMovie, required Movie newMovie}) {
    _box.remove(oldMovie.id);
    _box.put(newMovie);
    ref.invalidateSelf();
  }
}
