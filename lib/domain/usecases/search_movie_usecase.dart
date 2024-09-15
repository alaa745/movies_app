import 'package:movies_app/domain/models/dtos/movies_response_dto.dart';
import 'package:movies_app/domain/repository/movies_repository.dart';

class SearchMovieUsecase {
  MoviesRepository repository;

  SearchMovieUsecase(this.repository);

  Future<MoviesResponseDto> invoke(String movieQuery) {
    return repository.searchMovie(movieQuery);
  }
}
