import 'dart:convert';

import 'result_dto.dart';

class MoviesResponseDto {
  int? page;
  List<MovieResultDto>? results;
  int? totalPages;
  int? totalResults;
  String? statusMessage;
  int? statusCode;
  bool? success;

  MoviesResponseDto({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
    this.statusCode,
    this.statusMessage,
    this.success,
  });
}
