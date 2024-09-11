import 'dart:convert';

import 'package:movies_app/domain/models/dtos/movies_response_dto.dart';

import 'movie_result.dart';

class MovieResponse {
  int? page;
  List<MovieResult>? results;
  int? totalPages;
  int? totalResults;
  int? statusCode;
  String? statusMessage;
  bool? success;

  MovieResponse({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
    this.statusCode,
    this.statusMessage,
    this.success,
  });

  factory MovieResponse.fromMap(Map<String, dynamic> data) {
    return MovieResponse(
      page: data['page'] as int?,
      results: (data['results'] as List<dynamic>?)
          ?.map((e) => MovieResult.fromMap(e as Map<String, dynamic>))
          .toList(),
      totalPages: data['total_pages'] as int?,
      statusCode: data['status_code'] as int?,
      statusMessage: data['status_message'] as String?,
      success: data['success'] as bool?,
      totalResults: data['total_results'] as int?,
    );
  }

  Map<String, dynamic> toMap() => {
        'page': page,
        'results': results?.map((e) => e.toMap()).toList(),
        'total_pages': totalPages,
        'total_results': totalResults,
        'status_code': statusCode,
        'status_message': statusMessage,
        'success': success,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PopularMoviesResponse].
  factory MovieResponse.fromJson(String data) {
    return MovieResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PopularMoviesResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  MoviesResponseDto toDto() {
    return MoviesResponseDto(
      page: page,
      totalPages: totalPages,
      totalResults: totalResults,
      statusCode: statusCode,
      statusMessage: statusMessage,
      success: success,
      results: results?.map((movie) => movie.toDto()).toList(),
    );
  }
}
