import 'package:movies_app/domain/models/dtos/result_dto.dart';
import 'package:movies_app/domain/repository/movies_repository.dart';

class DeleteMovieUsecase {
  MoviesRepository _moviesRepository;
  DeleteMovieUsecase(this._moviesRepository);

  Future<void> invoke(int id) {
    return _moviesRepository.deleteMovie(id);
  }
}
