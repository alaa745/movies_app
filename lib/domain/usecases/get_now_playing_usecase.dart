import 'package:movies_app/domain/models/dtos/now_playing_movies_response_dto.dart';
import 'package:movies_app/domain/models/dtos/movies_response_dto.dart';
import 'package:movies_app/domain/repository/movies_repository.dart';

class GetNowPlayingUsecase {
  MoviesRepository repository;

  GetNowPlayingUsecase({required this.repository});

  Future<MoviesResponseDto> invoke() {
    return repository.getNowPlayingMovies();
  }
}
