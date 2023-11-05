import 'package:flutter/material.dart';

const List<String> filmNames = <String>['Титаник', 'Девчата'];
const List<int> filmYears = <int>[1999, 1954];

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text('Мой Кинопоиск'),
            titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
            backgroundColor: Colors.brown),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: 3,
                  itemExtent: 110,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                        background: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: 80,
                          color: Colors.red,
                          margin: EdgeInsets.all(11),
                          child: Icon(Icons.delete_forever_rounded),
                          alignment: Alignment.centerRight,
                        ),
                        key: ValueKey<int>(index),
                        child: MovieListItem(
                          movieTitle: "Летят журавли",
                          movieDate: "1957",
                          movieCountry: "СССР",
                        ));
                  }),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {}, label: const Text("Добавить фильм")));
  }
}

class MovieListItem extends StatelessWidget {
  final String movieTitle;
  final String movieDate;
  final String movieCountry;
  const MovieListItem(
      {super.key,
      required this.movieTitle,
      required this.movieDate,
      required this.movieCountry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.brown),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Align(
          alignment: const Alignment(-0.9, 1.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                movieTitle,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.brown),
              ),
              const SizedBox(height: 5),
              Text(movieDate),
              Text(movieCountry)
            ],
          ),
        ),
      ),
    );
  }
}
