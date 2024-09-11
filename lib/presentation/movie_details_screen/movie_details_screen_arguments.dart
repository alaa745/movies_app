import 'package:movies_app/domain/models/dtos/genre_list_dto.dart';
import 'package:movies_app/domain/models/dtos/result_dto.dart';

class MovieDetailsScreenArguments {
  MovieResultDto movieResultDto;
  GenreListDto? genreListDto;
  MovieDetailsScreenArguments(
      {required this.movieResultDto, this.genreListDto});
}
