import 'package:movies_app/domain/models/dtos/genre_list_dto.dart';
import 'package:movies_app/domain/models/dtos/result_dto.dart';

class BrowseTabArguments {
  List<MovieResultDto> moviesList;
  GenreListDto genreList;
  BrowseTabArguments(this.moviesList, this.genreList);
}
