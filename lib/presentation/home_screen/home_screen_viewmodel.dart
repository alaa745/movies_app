import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/api/api_manager.dart';
import 'package:movies_app/data/datasource/movies_datasource_impl.dart';
import 'package:movies_app/data/repository/movies_repository_impl.dart';
import 'package:movies_app/domain/datasource/movies_datasource.dart';
import 'package:movies_app/domain/models/customException/custom_exception.dart';
import 'package:movies_app/domain/models/dtos/result_dto.dart';
import 'package:movies_app/domain/repository/movies_repository.dart';
import 'package:movies_app/domain/usecases/get_now_playing_usecase.dart';
import 'package:movies_app/domain/usecases/get_popular_movies_usecase.dart';
import 'package:movies_app/domain/usecases/get_top_rated_movies_usecase.dart';

class HomeScreenViewmodel extends Cubit<HomeViewState> {
  late ApiManager apiManager;
  late MoviesRepository moviesRepository;
  late MoviesDatasource moviesDatasource;
  late GetPopularMoviesUsecase usecase;
  late GetNowPlayingUsecase _nowPlayingUsecase;
  late GetTopRatedMoviesUsecase _topRatedMoviesUsecase;

  HomeScreenViewmodel() : super(HomeInitialState()) {
    apiManager = ApiManager();
    moviesDatasource = MoviesDatasourceImpl(apiManager);
    moviesRepository = MoviesRepositoryImpl(moviesDatasource);
    usecase = GetPopularMoviesUsecase(repository: moviesRepository);
    _nowPlayingUsecase = GetNowPlayingUsecase(repository: moviesRepository);
    _topRatedMoviesUsecase = GetTopRatedMoviesUsecase(moviesRepository);
  }

  Future<void> getPopularMovies() async {
    try {
      emit(GetPopularMoviesLoadingState('Loading...'));

      var response = await usecase.invoke();
      emit(GetPopularMoviesSuccessState(response.results!));
    } on ServerErrorException catch (e) {
      emit(GetPopularMoviesFailState(
          failMessage: e.errorMessage, statusCode: e.statusCode));
    } on Exception catch (e) {
      emit(GetPopularMoviesFailState(failMessage: e.toString()));
    }
  }

  Future<void> getNowPlayingMovies() async {
    emit(GetNowPlayingMoviesLoadingState('Loading...'));
    try {
      var response = await _nowPlayingUsecase.invoke();
      emit(GetNowPlayingMoviesSuccessState(response.results!));
    } on ServerErrorException catch (e) {
      emit(GetNowPlayingMoviesFailState(
          failMessage: e.errorMessage, statusCode: e.statusCode));
    } on Exception catch (e) {
      emit(GetNowPlayingMoviesFailState(failMessage: e.toString()));
    }
  }

  Future<void> getTopRatedMovies() async {
    emit(GetTopRatedMoviesLoadingState('Loading...'));
    try {
      var response = await _topRatedMoviesUsecase.invoke();
      emit(GetTopRatedMoviesSuccessState(response.results!));
    } on ServerErrorException catch (e) {
      emit(GetTopRatedMoviesFailState(
          failMessage: e.errorMessage, statusCode: e.statusCode));
    } on Exception catch (e) {
      emit(GetTopRatedMoviesFailState(failMessage: e.toString()));
    }
  }
}

abstract class HomeViewState {}

class HomeInitialState extends HomeViewState {}

class GetPopularMoviesSuccessState extends HomeViewState {
  List<MovieResultDto> popularMoviesList;
  GetPopularMoviesSuccessState(this.popularMoviesList);
}

class GetPopularMoviesLoadingState extends HomeViewState {
  String loadingMessage;

  GetPopularMoviesLoadingState(this.loadingMessage);
}

class GetPopularMoviesFailState extends HomeViewState {
  String? failMessage;
  int? statusCode;

  GetPopularMoviesFailState({this.failMessage, this.statusCode});
}

class GetNowPlayingMoviesSuccessState extends HomeViewState {
  List<MovieResultDto> nowPlayingMoviesList;
  GetNowPlayingMoviesSuccessState(this.nowPlayingMoviesList);
}

class GetNowPlayingMoviesLoadingState extends HomeViewState {
  String loadingMessage;

  GetNowPlayingMoviesLoadingState(this.loadingMessage);
}

class GetNowPlayingMoviesFailState extends HomeViewState {
  String? failMessage;
  int? statusCode;

  GetNowPlayingMoviesFailState({this.failMessage, this.statusCode});
}

class GetTopRatedMoviesSuccessState extends HomeViewState {
  List<MovieResultDto> topRatedMovies;
  GetTopRatedMoviesSuccessState(this.topRatedMovies);
}

class GetTopRatedMoviesLoadingState extends HomeViewState {
  String loadingMessage;

  GetTopRatedMoviesLoadingState(this.loadingMessage);
}

class GetTopRatedMoviesFailState extends HomeViewState {
  String? failMessage;
  int? statusCode;

  GetTopRatedMoviesFailState({this.failMessage, this.statusCode});
}
