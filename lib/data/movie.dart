import 'package:objectbox/objectbox.dart';

@Entity()
class Movie {
  @Id()
  int id = 0;

  String name;
  String year;
  String country;

  Movie({
    required this.name,
    required this.year,
    required this.country,
  });
}
