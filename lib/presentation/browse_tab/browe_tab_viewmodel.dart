import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/api/api_manager.dart';
import 'package:movies_app/data/datasource/movies_datasource_impl.dart';
import 'package:movies_app/data/repository/movies_repository_impl.dart';
import 'package:movies_app/domain/datasource/movies_datasource.dart';
import 'package:movies_app/domain/models/customException/custom_exception.dart';
import 'package:movies_app/domain/models/dtos/movies_response_dto.dart';
import 'package:movies_app/domain/models/dtos/result_dto.dart';
import 'package:movies_app/domain/repository/movies_repository.dart';
import 'package:movies_app/domain/usecases/filter_movie_with_genre_usecase.dart';
import 'package:movies_app/domain/usecases/search_movie_usecase.dart';

class BrowseTabViewmodel extends Cubit<BrowseTabViewState> {
  late ApiManager apiManager;
  late MoviesRepository moviesRepository;
  late MoviesDatasource moviesDatasource;
  late FilterMovieWithGenreUsecase usecase;

  BrowseTabViewmodel() : super(BrowseTabInitialState()) {
    apiManager = ApiManager();
    moviesDatasource = MoviesDatasourceImpl(apiManager);
    moviesRepository = MoviesRepositoryImpl(moviesDatasource);
    usecase = FilterMovieWithGenreUsecase(moviesRepository);
  }

  Future<void> filterMovieWithGenre(String genreId) async {
    try {
      emit(BrowseTabLoadingState('Loading...'));
      var response = await usecase.invoke(genreId);
      emit(BrowseTabSuccessState(response.results!));
    } on ServerErrorException catch (e) {
      emit(BrowseTabFailState(
          failMessage: e.errorMessage, statusCode: e.statusCode));
    } on Exception catch (e) {
      emit(BrowseTabFailState(failMessage: e.toString()));
    }
  }
}

abstract class BrowseTabViewState {}

class BrowseTabInitialState extends BrowseTabViewState {}

class BrowseTabLoadingState extends BrowseTabViewState {
  String loadingMessage;

  BrowseTabLoadingState(this.loadingMessage);
}

class BrowseTabFailState extends BrowseTabViewState {
  String? failMessage;
  int? statusCode;

  BrowseTabFailState({this.failMessage, this.statusCode});
}

class BrowseTabSuccessState extends BrowseTabViewState {
  List<MovieResultDto> moviesList;

  BrowseTabSuccessState(this.moviesList);
}
