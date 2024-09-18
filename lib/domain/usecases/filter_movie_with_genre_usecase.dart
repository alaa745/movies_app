import 'package:movies_app/domain/models/dtos/movies_response_dto.dart';
import 'package:movies_app/domain/models/dtos/result_dto.dart';
import 'package:movies_app/domain/repository/movies_repository.dart';

class FilterMovieWithGenreUsecase {
  MoviesRepository repository;

  FilterMovieWithGenreUsecase(this.repository);

  Future<MoviesResponseDto> invoke(String genreID) {
    return repository.filterMovieCategory(genreID);
  }
}
