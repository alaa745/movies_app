import 'dart:convert';
import 'dart:ffi';

class MovieResultDto {
  bool? adult;
  String? backdropPath;
  int? id;
  List<int>? genreIds;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  MovieResultDto({
    this.adult,
    this.backdropPath,
    this.id,
    this.genreIds,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

    factory MovieResultDto.fromMap(Map<String, dynamic> data) =>
      MovieResultDto(
        adult: data['adult'] as bool?,
        backdropPath: data['backdrop_path'] as String?,
        id: data['id'] as int?,
        genreIds: (data['genre_ids'] as List<dynamic>?)?.map((id) => id as int).toList(),
        originalLanguage: data['original_language'] as String?,
        originalTitle: data['original_title'] as String?,
        overview: data['overview'] as String?,
        popularity: (data['popularity'] as num?)?.toDouble(),
        posterPath: data['poster_path'] as String?,
        releaseDate: data['release_date'] as String?,
        title: data['title'] as String?,
        video: data['video'] as bool?,
        voteAverage: (data['vote_average'] as num?)?.toDouble(),
        voteCount: data['vote_count'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'adult': adult,
        'backdrop_path': backdropPath,
        'id': id,
        'original_language': originalLanguage,
        'original_title': originalTitle,
        'overview': overview,
        'popularity': popularity,
        'poster_path': posterPath,
        'release_date': releaseDate,
        'title': title,
        'genre_ids': genreIds,
        'video': video,
        'vote_average': voteAverage,
        'vote_count': voteCount,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MovieResult].
  factory MovieResultDto.fromJson(String data) {
    return MovieResultDto.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PopularMovieResult] to a JSON string.
  String toJson() => json.encode(toMap());
}
