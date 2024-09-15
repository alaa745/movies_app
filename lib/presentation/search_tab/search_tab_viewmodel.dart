import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/api/api_manager.dart';
import 'package:movies_app/data/datasource/movies_datasource_impl.dart';
import 'package:movies_app/data/repository/movies_repository_impl.dart';
import 'package:movies_app/domain/datasource/movies_datasource.dart';
import 'package:movies_app/domain/models/customException/custom_exception.dart';
import 'package:movies_app/domain/models/dtos/movies_response_dto.dart';
import 'package:movies_app/domain/models/dtos/result_dto.dart';
import 'package:movies_app/domain/repository/movies_repository.dart';
import 'package:movies_app/domain/usecases/search_movie_usecase.dart';

class SearchTabViewmodel extends Cubit<SearchTabViewState> {
  late ApiManager apiManager;
  late MoviesRepository moviesRepository;
  late MoviesDatasource moviesDatasource;
  late SearchMovieUsecase usecase;

  SearchTabViewmodel() : super(SearchTabInitialState()) {
    apiManager = ApiManager();
    moviesDatasource = MoviesDatasourceImpl(apiManager);
    moviesRepository = MoviesRepositoryImpl(moviesDatasource);
    usecase = SearchMovieUsecase(moviesRepository);
  }

  Future<void> searchMovie(String movieQuery) async {
    try {
      emit(SearchTabLoadingState('Loading...'));
      var response = await usecase.invoke(movieQuery);
      emit(SearchTabSuccessState(response.results!));
    } on ServerErrorException catch (e) {
      emit(SearchTabFailState(
          failMessage: e.errorMessage, statusCode: e.statusCode));
    } on Exception catch (e) {
      emit(SearchTabFailState(failMessage: e.toString()));
    }
  }
}

abstract class SearchTabViewState {}

class SearchTabInitialState extends SearchTabViewState {}

class SearchTabLoadingState extends SearchTabViewState {
  String loadingMessage;

  SearchTabLoadingState(this.loadingMessage);
}

class SearchTabFailState extends SearchTabViewState {
  String? failMessage;
  int? statusCode;

  SearchTabFailState({this.failMessage, this.statusCode});
}

class SearchTabSuccessState extends SearchTabViewState {
  List<MovieResultDto> moviesList;

  SearchTabSuccessState(this.moviesList);
}
