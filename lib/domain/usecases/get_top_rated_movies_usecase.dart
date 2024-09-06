import 'package:movies_app/domain/models/dtos/movies_response_dto.dart';
import 'package:movies_app/domain/models/dtos/result_dto.dart';
import 'package:movies_app/domain/repository/movies_repository.dart';

class GetTopRatedMoviesUsecase {
  MoviesRepository _repository;

  GetTopRatedMoviesUsecase(this._repository);

  Future<MoviesResponseDto> invoke() {
    return _repository.getTopRatedMovies();
  }
}
