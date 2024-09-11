import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:movies_app/data/api/interceptor/LoggingInterceptor.dart';
import 'package:movies_app/domain/models/constants/constant.dart';
import 'package:movies_app/domain/models/customException/custom_exception.dart';
import 'package:movies_app/domain/models/dtos/genre_list_dto.dart';
import 'package:movies_app/domain/models/dtos/movies_response_dto.dart';
import 'package:movies_app/domain/models/genre_list/genre_list.dart';
import 'package:movies_app/domain/models/movies_response.dart';

class ApiManager {
  static const String baseUrl = 'api.themoviedb.org';
  Client client = InterceptedClient.build(
    interceptors: [
      LoggingInterceptor(),
    ],
  );
  Future<GenreList> getGenresList() async {
    late Response response;
    try {
      var url = Uri.https(
        baseUrl,
        '/3/genre/movie/list',
        {
          'language': 'en-US',
          'page': '1',
        },
      );
      response = await client.get(url, headers: {
        'Authorization': Constant.apiKey,
      });
      var genreListResponse = GenreList.fromJson(response.body);
      return genreListResponse;
    } on ServerErrorException catch (e) {
      throw ServerErrorException(errorMessage: e.errorMessage);
    }
  }

  Future<MovieResponse> getTopMovies() async {
    late Response response;
    try {
      var url = Uri.https(
        baseUrl,
        '/3/movie/popular',
        {
          'language': 'en-US',
          'page': '1',
        },
      );
      response = await client.get(url, headers: {
        'Authorization': Constant.apiKey,
      });
      var topMoviesResponse = MovieResponse.fromJson(response.body);
      if (topMoviesResponse.success == false) {
        throw ServerErrorException(
            errorMessage: topMoviesResponse.statusMessage!,
            statusCode: topMoviesResponse.statusCode);
      }
      return topMoviesResponse;
    } on ServerErrorException catch (e) {
      throw ServerErrorException(errorMessage: e.errorMessage);
    } on Exception catch (e) {
      throw ServerErrorException(errorMessage: e.toString());
    }
  }

  Future<MovieResponse> getNowPlaying() async {
    late Response response;
    try {
      var url = Uri.https(
        baseUrl,
        '/3/movie/now_playing',
        {
          'language': 'en-US',
          'page': '1',
        },
      );
      response = await client.get(url, headers: {
        'Authorization': Constant.apiKey,
      });
      var nowPlayingResponse = MovieResponse.fromJson(response.body);
      if (nowPlayingResponse.success == false) {
        throw ServerErrorException(
            errorMessage: nowPlayingResponse.statusMessage!,
            statusCode: nowPlayingResponse.statusCode);
      }
      return nowPlayingResponse;
    } on ServerErrorException catch (e) {
      throw ServerErrorException(errorMessage: e.errorMessage);
    } on Exception catch (e) {
      throw ServerErrorException(errorMessage: e.toString());
    }
  }

  Future<MovieResponse> getTopRatedMovies() async {
    late Response response;
    try {
      var url = Uri.https(
        baseUrl,
        '/3/movie/top_rated',
        {
          'language': 'en-US',
          'page': '1',
        },
      );
      response = await client.get(url, headers: {
        'Authorization': Constant.apiKey,
      });
      var nowPlayingResponse = MovieResponse.fromJson(response.body);
      if (nowPlayingResponse.success == false) {
        throw ServerErrorException(
            errorMessage: nowPlayingResponse.statusMessage!,
            statusCode: nowPlayingResponse.statusCode);
      }
      return nowPlayingResponse;
    } on ServerErrorException catch (e) {
      throw ServerErrorException(errorMessage: e.errorMessage);
    } on Exception catch (e) {
      throw ServerErrorException(errorMessage: e.toString());
    }
  }

  Future<MovieResponse> getMoreLikeThis(int movieId) async {
    late Response response;
    try {
      var url = Uri.https(
        baseUrl,
        '/3/movie/$movieId/recommendations',
        {
          'language': 'en-US',
          'page': '1',
        },
      );
      response = await client.get(url, headers: {
        'Authorization': Constant.apiKey,
      });
      var moreLikeThisResponse = MovieResponse.fromJson(response.body);
      if (moreLikeThisResponse.success == false) {
        throw ServerErrorException(
            errorMessage: moreLikeThisResponse.statusMessage!,
            statusCode: moreLikeThisResponse.statusCode);
      }
      return moreLikeThisResponse;
    } on ServerErrorException catch (e) {
      throw ServerErrorException(errorMessage: e.errorMessage);
    } on Exception catch (e) {
      throw ServerErrorException(errorMessage: e.toString());
    }
  }
}
