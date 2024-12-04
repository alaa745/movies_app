import 'package:movies_app/domain/models/dtos/result_dto.dart';
import 'package:movies_app/domain/repository/movies_repository.dart';

class GetMoviesFromDatabaseUsecase {
  MoviesRepository _moviesRepository;
  GetMoviesFromDatabaseUsecase(this._moviesRepository);

  Future<List<MovieResultDto>> invoke() async{
    return await _moviesRepository.getMovies();
  }
}
