import 'package:movies_app/data/datasource/movies_datasource_impl.dart';
import 'package:movies_app/domain/datasource/movies_datasource.dart';
import 'package:movies_app/domain/models/dtos/movies_response_dto.dart';
import 'package:movies_app/domain/repository/movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  MoviesDatasource dataSource;

  MoviesRepositoryImpl(this.dataSource);

  @override
  Future<MoviesResponseDto> getPopularMovies() {
    return dataSource.getPopularMovies();
  }

  @override
  Future<MoviesResponseDto> getNowPlayingMovies() {
    return dataSource.getNowPlayingMovies();
  }

  @override
  Future<MoviesResponseDto> getTopRatedMovies() {
    return dataSource.getTopRatedMovies();
  }

  @override
  Future<MoviesResponseDto> getMoreLikeThis(int movieId) {
    return dataSource.getMoreLikeThis(movieId);
  }

  @override
  Future<MoviesResponseDto> searchMovie(String movieQuery) {
    return dataSource.searchMovie(movieQuery);
  }

  @override
  Future<MoviesResponseDto> filterMovieCategory(String genreId) {
    return dataSource.filterMovieCategory(genreId);
  }
}
