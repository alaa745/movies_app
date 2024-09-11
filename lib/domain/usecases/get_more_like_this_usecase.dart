import 'package:movies_app/domain/models/dtos/movies_response_dto.dart';
import 'package:movies_app/domain/repository/movies_repository.dart';

class GetMoreLikeThisUsecase {
  MoviesRepository repository;

  GetMoreLikeThisUsecase({required this.repository});

  Future<MoviesResponseDto> invoke(int movieId) {
    return repository.getMoreLikeThis(movieId);
  }
}
