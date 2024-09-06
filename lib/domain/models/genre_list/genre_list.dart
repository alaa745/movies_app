import 'dart:convert';

import 'package:movies_app/domain/models/dtos/genre_list_dto.dart';

import 'genre.dart';

class GenreList {
  List<Genre>? genres;

  GenreList({this.genres});

  factory GenreList.fromMap(Map<String, dynamic> data) => GenreList(
        genres: (data['genres'] as List<dynamic>?)
            ?.map((e) => Genre.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'genres': genres?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [GenreList].
  factory GenreList.fromJson(String data) {
    return GenreList.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [GenreList] to a JSON string.
  String toJson() => json.encode(toMap());

  GenreListDto toDto() {
    return GenreListDto(
      genres: genres?.map((genre) => genre.toDto()).toList(),
    );
  }
}
