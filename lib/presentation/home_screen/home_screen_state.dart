import 'dart:ffi';

import 'package:movies_app/domain/models/dtos/result_dto.dart';

class HomeScreenState {
  late List<MovieResultDto> popularMovies;
  late List<MovieResultDto> nowPlayingMovies;
  late List<MovieResultDto> topRatedMovies;
  late bool isLoading;
  late bool isNowPlayingLoading;
  late bool isRecommendedLoading;
  late String errorMessage;
  late int statusCode;
  HomeScreenState({
    this.popularMovies = const [],
    this.nowPlayingMovies = const [],
    this.errorMessage = "",
    this.isLoading = false,
    this.isNowPlayingLoading = false,
    this.isRecommendedLoading = false,
    this.topRatedMovies = const [],
    this.statusCode = 0,
  });

  HomeScreenState copyWith({
    List<MovieResultDto>? popularMovies,
    List<MovieResultDto>? nowPlayingMovies,
    List<MovieResultDto>? topRatedMovies,
    bool? isLoading,
    bool? isNowPlayingLoading,
    bool? isRecommendedLoading,
    String? errorMessage,
    int? statusCode,
  }) {
    return HomeScreenState(
      popularMovies: popularMovies ?? this.popularMovies,
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      isLoading: isLoading ?? this.isLoading,
      isNowPlayingLoading: isNowPlayingLoading ?? this.isNowPlayingLoading,
      isRecommendedLoading: isRecommendedLoading ?? this.isRecommendedLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      statusCode: statusCode ?? this.statusCode,
    );
  }
}
