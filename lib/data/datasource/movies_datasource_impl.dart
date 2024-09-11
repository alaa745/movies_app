import 'package:movies_app/data/api/api_manager.dart';
import 'package:movies_app/domain/datasource/movies_datasource.dart';
import 'package:movies_app/domain/models/dtos/movies_response_dto.dart';

class MoviesDatasourceImpl implements MoviesDatasource {
  ApiManager apiManager;

  MoviesDatasourceImpl(this.apiManager);

  @override
  Future<MoviesResponseDto> getPopularMovies() async {
    var response = await apiManager.getTopMovies();

    return response.toDto();
  }

  @override
  Future<MoviesResponseDto> getNowPlayingMovies() async {
    var response = await apiManager.getNowPlaying();

    return response.toDto();
  }

  @override
  Future<MoviesResponseDto> getTopRatedMovies() async {
    var response = await apiManager.getTopRatedMovies();

    return response.toDto();
  }

  @override
  Future<MoviesResponseDto> getMoreLikeThis(int movieId) async {
    var response = await apiManager.getMoreLikeThis(movieId);

    return response.toDto();
  }
}
