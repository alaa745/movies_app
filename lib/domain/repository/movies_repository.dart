import 'package:movies_app/domain/models/dtos/now_playing_movies_response_dto.dart';
import 'package:movies_app/domain/models/dtos/movies_response_dto.dart';

abstract class MoviesRepository {
  Future<MoviesResponseDto> getPopularMovies();
  Future<MoviesResponseDto> getNowPlayingMovies();
  Future<MoviesResponseDto> getTopRatedMovies();

}
