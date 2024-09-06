import 'package:movies_app/domain/models/dtos/movies_response_dto.dart';
import 'package:movies_app/domain/repository/movies_repository.dart';

class GetPopularMoviesUsecase {
  MoviesRepository repository;

  GetPopularMoviesUsecase({required this.repository});

  Future<MoviesResponseDto> invoke() {
    return repository.getPopularMovies();
  }
}
