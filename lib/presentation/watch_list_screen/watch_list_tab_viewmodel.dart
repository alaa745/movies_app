import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/data/local/database_helper.dart';
import 'package:movies_app/data/local/local_datasource.dart';
import 'package:movies_app/data/repository/movies_repository_impl.dart';
import 'package:movies_app/domain/models/customException/database_exception.dart';
import 'package:movies_app/domain/models/dtos/result_dto.dart';
import 'package:movies_app/domain/repository/movies_repository.dart';
import 'package:movies_app/domain/usecases/delete_movie_usecase.dart';
import 'package:movies_app/domain/usecases/get_movies_from_database.dart';
import 'package:movies_app/domain/usecases/insert_movie_usecase.dart';

class WatchListTabViewmodel extends ChangeNotifier {
  late MoviesRepository moviesRepository;
  late LocalDatasource localDatasource;
  late GetMoviesFromDatabaseUsecase getMoviesFromDatabaseUsecase;
  late InsertMovieUsecase insertMovieUsecase;
  late DeleteMovieUsecase deleteMovieUsecase;
  late DatabaseHelper databaseHelper;
  List<MovieResultDto> _movies = [];
  List<MovieResultDto> get movies => _movies;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isError = false;
  bool get isError => _isError;
  WatchListTabViewmodel() {
    databaseHelper = DatabaseHelper();
    localDatasource = LocalDatasource(databaseHelper);

    moviesRepository = MoviesRepositoryImpl(localDatasource: localDatasource);
    getMoviesFromDatabaseUsecase =
        GetMoviesFromDatabaseUsecase(moviesRepository);
    insertMovieUsecase = InsertMovieUsecase(moviesRepository);
    deleteMovieUsecase = DeleteMovieUsecase(moviesRepository);
    getMovies();
  }

  Future<void> getMovies() async {
    print('localllllll');
    try {
      print('gettttttttttt');

      _movies = await getMoviesFromDatabaseUsecase.invoke();
      print('moviesssssss');
    } catch (e) {
      _isError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> insertMovie(MovieResultDto movie) async {
    try {
      await insertMovieUsecase.invoke(movie);
      await getMovies();
    } catch (e) {
      print('errorrrr');
      throw DatabaseCustomException(e.toString());
    }
    notifyListeners();
  }

  Future<void> deleteMovie(int id) async {
    try {
      await deleteMovieUsecase.invoke(id);
      await getMovies();
    } catch (e) {
      print('errorrrr');
      throw DatabaseCustomException(e.toString());
    }
    notifyListeners();
  }
}
