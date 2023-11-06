import 'package:dropdownfield2/dropdownfield2.dart';
import 'package:flutter/material.dart';
import 'package:kinopoisk_angelina/state/movie.dart';
import '../state/movies_notifier.dart';

class DetailScreen extends StatefulWidget {
  final Movie? movie;
  const DetailScreen({super.key, this.movie});

  @override
  State<DetailScreen> createState() => _DetailScreenState();

  List<String> get years => List.generate(100, (index) => "${1925 + index}");
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('О фильме ${widget.movie?.name}'),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
          backgroundColor: Colors.brown),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.brown[100],
                      hintText: "Название фильма",
                    ),
                  ),
                ),
                SizedBox(width: 47),
              ],
            ),
            SizedBox(height: 15),
            DropDownField(
              controller: countriesSelected,
              hintText: "Выберите страну создания фильма",
              enabled: true,
              itemsVisibleInDropdown: 9,
              items: countries,
              onValueChanged: (value) {},
            ),
            SizedBox(height: 15),
            DropDownField(
              controller: yearsSelected,
              hintText: "Выберите год создания фильма",
              enabled: true,
              itemsVisibleInDropdown: 5,
              items: widget.years,
              onValueChanged: (value) {},
            )
          ],
        ),
      ),
    );
    // floatingActionButton:
    // FloatingActionButton.extended(
    //     onPressed: () {}, label: const Text("Редактировать"));
  }
}

final countriesSelected = TextEditingController();

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

final yearsSelected = TextEditingController();
