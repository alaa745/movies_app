import 'package:movies_app/domain/models/dtos/movies_response_dto.dart';

abstract class MoviesDatasource {
  Future<MoviesResponseDto> getPopularMovies();
  Future<MoviesResponseDto> getNowPlayingMovies();
  Future<MoviesResponseDto> getTopRatedMovies();
  Future<MoviesResponseDto> getMoreLikeThis(int movieId);
}
