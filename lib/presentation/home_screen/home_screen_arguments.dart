import 'package:movies_app/domain/models/dtos/genre_list_dto.dart';
import 'package:movies_app/domain/models/dtos/result_dto.dart';

class HomeScreenArguments {
  GenreListDto genreListDto;
  HomeScreenArguments({required this.genreListDto});
}
