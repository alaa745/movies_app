import 'dart:convert';

import 'package:movies_app/domain/models/dtos/result_dto.dart';


class NowPlayingMoviesResponseDto {
  int? page;
  List<MovieResultDto>? results;
  int? totalPages;
  int? totalResults;
  int? statusCode;
  String? statusMessage;
  bool? success;

  NowPlayingMoviesResponseDto({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
    this.statusCode,
    this.statusMessage,
    this.success,
  });
}
