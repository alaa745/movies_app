import 'package:movies_app/domain/models/dtos/result_dto.dart';

class SearchTabArguments {
  List<MovieResultDto> moviesList;
  SearchTabArguments(this.moviesList);
}
