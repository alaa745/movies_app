import 'package:movies_app/data/local/database_helper.dart';
import 'package:movies_app/domain/models/customException/database_exception.dart';
import 'package:movies_app/domain/models/dtos/result_dto.dart';

class LocalDatasource {
  final DatabaseHelper _databaseHelper;
  LocalDatasource(this._databaseHelper);

  Future<void> insertMovie(MovieResultDto movie) async {
    try {
      await _databaseHelper.insertMovie(movie);
    } catch (e) {
      throw DatabaseCustomException(e.toString());
    }
  }

  Future<List<MovieResultDto>> getMovies() async {
    return await _databaseHelper.getMovies();
  }

  Future<void> deleteMovie(int id) async {
    return await _databaseHelper.deleteMovie(id);
  }
}
