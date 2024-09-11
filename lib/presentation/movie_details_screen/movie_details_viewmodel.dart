import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/api/api_manager.dart';
import 'package:movies_app/data/datasource/movies_datasource_impl.dart';
import 'package:movies_app/data/repository/movies_repository_impl.dart';
import 'package:movies_app/domain/datasource/movies_datasource.dart';
import 'package:movies_app/domain/models/customException/custom_exception.dart';
import 'package:movies_app/domain/models/dtos/result_dto.dart';
import 'package:movies_app/domain/repository/movies_repository.dart';
import 'package:movies_app/domain/usecases/get_more_like_this_usecase.dart';
import 'package:movies_app/domain/usecases/get_now_playing_usecase.dart';
import 'package:movies_app/domain/usecases/get_popular_movies_usecase.dart';
import 'package:movies_app/domain/usecases/get_top_rated_movies_usecase.dart';

class MovieDetailsViewmodel extends Cubit<MovieDetailsViewState> {
  late ApiManager apiManager;
  late MoviesRepository moviesRepository;
  late MoviesDatasource moviesDatasource;
  late GetMoreLikeThisUsecase usecase;

  MovieDetailsViewmodel() : super(MovieDetailsInitialState()) {
    apiManager = ApiManager();
    moviesDatasource = MoviesDatasourceImpl(apiManager);
    moviesRepository = MoviesRepositoryImpl(moviesDatasource);
    usecase = GetMoreLikeThisUsecase(repository: moviesRepository);
  }

  Future<void> getMoreLikeThis(int movieId) async {
    try {
      emit(GetMoreLikeThisLoadingState('Loading...'));

      var response = await usecase.invoke(movieId);
      emit(GetMoreLikeThisSuccessState(response.results!));
    } on ServerErrorException catch (e) {
      emit(GetMoreLikeThisFailState(
          failMessage: e.errorMessage, statusCode: e.statusCode));
    } on Exception catch (e) {
      emit(GetMoreLikeThisFailState(failMessage: e.toString()));
    }
  }
}

abstract class MovieDetailsViewState {}

class MovieDetailsInitialState extends MovieDetailsViewState {}

class GetMoreLikeThisSuccessState extends MovieDetailsViewState {
  List<MovieResultDto> popularMoviesList;
  GetMoreLikeThisSuccessState(this.popularMoviesList);
}

class GetMoreLikeThisLoadingState extends MovieDetailsViewState {
  String loadingMessage;

  GetMoreLikeThisLoadingState(this.loadingMessage);
}

class GetMoreLikeThisFailState extends MovieDetailsViewState {
  String? failMessage;
  int? statusCode;

  GetMoreLikeThisFailState({this.failMessage, this.statusCode});
}
