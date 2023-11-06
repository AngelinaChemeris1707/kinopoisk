import 'package:flutter/material.dart';

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
