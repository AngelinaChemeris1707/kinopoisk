import 'package:dropdownfield2/dropdownfield2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinopoisk_angelina/state/movie.dart';
import '../state/movies_notifier.dart';

class DetailScreen extends ConsumerStatefulWidget {
  final Movie? movie;
  const DetailScreen({super.key, this.movie});

  @override
  ConsumerState<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> {
  List<String> get years => List.generate(100, (index) => "${1925 + index}");

  List<String> countries = [
    "Италия",
    "Казахстан",
    "Китай",
    "Россия",
    "СССР",
    "CША",
    "Франция",
    "Южная Корея",
    "Япония"
  ];

  Movie resultMovie = Movie(name: "", year: "", country: "");

  bool get isCreatingNewMovie => widget.movie == null;

  @override
  void initState() {
    super.initState();
    if (!isCreatingNewMovie) {
      final movie = widget.movie!;
      resultMovie =
          Movie(name: movie.name, year: movie.year, country: movie.country);
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(moviesNotifierProvider.notifier);
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('О фильме'),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  // Новый фильм, не передаем movie в конструктор DetailScreen
                  if (isCreatingNewMovie) {
                    notifier.add(movie: resultMovie);
                    Navigator.of(context).pop();
                    return;
                  }
                  // Редактируем текущий фильм
                  notifier.replace(
                      oldMovie: widget.movie!, newMovie: resultMovie);
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.check, color: Colors.white))
          ],
          backgroundColor: Colors.brown),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: TextEditingController(text: widget.movie?.name),
                    onChanged: (name) {
                      resultMovie.name = name;
                    },
                    style: const TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.brown[100],
                      hintText: "Название фильма",
                    ),
                  ),
                ),
                const SizedBox(width: 47),
              ],
            ),
            const SizedBox(height: 15),
            DropDownField(
              controller: TextEditingController(text: widget.movie?.country),
              hintText: "Выберите страну создания фильма",
              textStyle: const TextStyle(fontSize: 10),
              enabled: true,
              itemsVisibleInDropdown: 9,
              items: countries,
              onValueChanged: (value) {
                resultMovie.country = value;
              },
            ),
            const SizedBox(height: 15),
            DropDownField(
              controller: TextEditingController(text: widget.movie?.year),
              hintText: "Выберите год создания фильма",
              textStyle: const TextStyle(fontSize: 10),
              enabled: true,
              itemsVisibleInDropdown: 5,
              items: years,
              onValueChanged: (value) {
                resultMovie.year = value;
              },
            )
          ],
        ),
      ),
    );
  }
}
