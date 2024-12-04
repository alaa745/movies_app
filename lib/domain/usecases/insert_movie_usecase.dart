import 'package:movies_app/domain/models/dtos/result_dto.dart';
import 'package:movies_app/domain/repository/movies_repository.dart';

class InsertMovieUsecase {
  MoviesRepository _moviesRepository;
  InsertMovieUsecase(this._moviesRepository);

  Future<void> invoke(MovieResultDto movie) {
    return _moviesRepository.insertMovie(movie);
  }
}
