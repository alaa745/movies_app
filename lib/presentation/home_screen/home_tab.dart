import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/domain/models/dtos/result_dto.dart';
import 'package:movies_app/presentation/component/popular_movie_poster.dart';
import 'package:movies_app/presentation/component/poster_card_shimmer.dart';
import 'package:movies_app/presentation/component/poster_card_vertical.dart';
import 'package:movies_app/presentation/component/poster_cover_shimmer_card.dart';
import 'package:movies_app/presentation/component/top_rated_card.dart';
import 'package:movies_app/presentation/home_screen/home_screen_arguments.dart';
import 'package:movies_app/presentation/home_screen/home_screen_viewmodel.dart';
import 'package:movies_app/presentation/utils/dialog_utils.dart';

class HomeTab extends StatefulWidget {
  // static const routeName = 'HomeTab';

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  var isPopularLoading = true,
      isNowPlayingLoading = true,
      isTopRatedLoading = true;
  HomeScreenViewmodel? viewmodel;
  List<MovieResultDto>? popularMoviesList;
  List<MovieResultDto>? nowPlayingMoviesList;
  List<MovieResultDto>? topRatedMoviesList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewmodel = HomeScreenViewmodel();
    viewmodel?.getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as HomeScreenArguments;
    return BlocConsumer(
      bloc: viewmodel,
      listener: (BuildContext context, Object? state) {
        if (state is GetPopularMoviesLoadingState) {
          print('loadiiiiiing');
          isPopularLoading = true;
        } else if (state is GetPopularMoviesFailState) {
          print('status code ${state.statusCode}');
          if (Platform.isIOS) {
            DialogUtils.showDialogIos(
                alertMsg: 'Fail',
                alertContent: state.failMessage,
                statusCode: state.statusCode,
                // onAction: () {
                //   Navigator.pop(context);
                //   Navigator.pushReplacementNamed(context, 'Login',
                //       arguments: LoginScreenArguments(args!.countriesFlagsDto));
                // },
                context: context);
          } else {
            DialogUtils.showDialogAndroid(
                alertMsg: 'Fail',
                alertContent: state.failMessage,
                // onAction: () {
                //   Navigator.pop(context);
                //   Navigator.pushReplacementNamed(context, 'Login',
                //       arguments: LoginScreenArguments(args!.countriesFlagsDto));
                // },
                statusCode: state.statusCode,
                context: context);
          }
        }

        if (state is GetNowPlayingMoviesLoadingState) {
          isNowPlayingLoading = true;
        } else if (state is GetNowPlayingMoviesFailState) {
          print('status code ${state.statusCode}');
          if (Platform.isIOS) {
            DialogUtils.showDialogIos(
                alertMsg: 'Fail',
                alertContent: state.failMessage,
                statusCode: state.statusCode,
                // onAction: () {
                //   Navigator.pop(context);
                //   Navigator.pushReplacementNamed(context, 'Login',
                //       arguments: LoginScreenArguments(args!.countriesFlagsDto));
                // },
                context: context);
          } else {
            DialogUtils.showDialogAndroid(
                alertMsg: 'Fail',
                alertContent: state.failMessage,
                // onAction: () {
                //   Navigator.pop(context);
                //   Navigator.pushReplacementNamed(context, 'Login',
                //       arguments: LoginScreenArguments(args!.countriesFlagsDto));
                // },
                statusCode: state.statusCode,
                context: context);
          }
        }

        if (state is GetTopRatedMoviesLoadingState) {
          isTopRatedLoading = true;
        } else if (state is GetTopRatedMoviesFailState) {
          print('status code ${state.statusCode}');
          if (Platform.isIOS) {
            DialogUtils.showDialogIos(
                alertMsg: 'Fail',
                alertContent: state.failMessage,
                statusCode: state.statusCode,
                // onAction: () {
                //   Navigator.pop(context);
                //   Navigator.pushReplacementNamed(context, 'Login',
                //       arguments: LoginScreenArguments(args!.countriesFlagsDto));
                // },
                context: context);
          } else {
            DialogUtils.showDialogAndroid(
                alertMsg: 'Fail',
                alertContent: state.failMessage,
                // onAction: () {
                //   Navigator.pop(context);
                //   Navigator.pushReplacementNamed(context, 'Login',
                //       arguments: LoginScreenArguments(args!.countriesFlagsDto));
                // },
                statusCode: state.statusCode,
                context: context);
          }
        }
      },
      listenWhen: (previous, current) {
        if (current is GetPopularMoviesLoadingState ||
            current is GetPopularMoviesFailState ||
            current is GetNowPlayingMoviesLoadingState ||
            current is GetNowPlayingMoviesFailState ||
            current is GetTopRatedMoviesFailState ||
            current is GetTopRatedMoviesLoadingState) {
          return true;
        }
        if (previous is GetPopularMoviesLoadingState) {
          isPopularLoading = false;
        }
        if (previous is GetNowPlayingMoviesLoadingState) {
          isNowPlayingLoading = false;
        }
        if (previous is GetTopRatedMoviesLoadingState) {
          isTopRatedLoading = false;
        }
        return false;
      },
      builder: (BuildContext context, state) {
        if (state is GetPopularMoviesSuccessState) {
          popularMoviesList = state.popularMoviesList;
          print('moviesss ${popularMoviesList!.first.backdropPath}');
          isPopularLoading = false;
          viewmodel?.getNowPlayingMovies();
        }
        if (state is GetNowPlayingMoviesSuccessState) {
          nowPlayingMoviesList = state.nowPlayingMoviesList;
          isNowPlayingLoading = false;
          viewmodel?.getTopRatedMovies();
          // print('moviesss ${popularMoviesList!.first.backdropPath}');
          // isLoading = false;
        }
        if (state is GetTopRatedMoviesSuccessState) {
          topRatedMoviesList = state.topRatedMovies;
          isTopRatedLoading = false;
        }
        return Scaffold(
          backgroundColor: Color(0xFF121312),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  isPopularLoading
                      ? PosterCoverShimmerCard()
                      : PopularMoviePoster(
                          movieResultDto: popularMoviesList!.first,
                          genreListDto: args.genreListDto,
                        ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    color: Color(0xFF282A28),
                    width: MediaQuery.sizeOf(context).width,
                    // height: 230,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Text(
                            'Now Playing',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: 180,
                          child: isNowPlayingLoading
                              ? ListView.builder(
                                  itemCount: 5,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) =>
                                      ShimmerPosterCardVertical(),
                                )
                              : ListView.builder(
                                  itemCount: nowPlayingMoviesList?.length,
                                  padding: EdgeInsets.only(left: 10, right: 20),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) => Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: PosterCardVertical(
                                        height: 170,
                                        genreListDto: args.genreListDto,
                                        // iconWidth: 20,
                                        movieResultDto:
                                            nowPlayingMoviesList![index]),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    color: Color(0xFF282A28),
                    width: MediaQuery.sizeOf(context).width,
                    // height: 230,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Text(
                            'Recommended',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: 220,
                          padding: EdgeInsets.only(bottom: 10),
                          child: isTopRatedLoading
                              ? ListView.builder(
                                  itemCount: 5,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) =>
                                      ShimmerPosterCardVertical(),
                                )
                              : ListView.builder(
                                  itemCount: topRatedMoviesList?.length,
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 20),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) => Container(
                                    margin:
                                        EdgeInsets.only(bottom: 5, right: 10),
                                    child: TopRatedCard(
                                      // height: 170,
                                      // iconWidth: 20,
                                      genreListDto: args.genreListDto,
                                      movieResultDto:
                                          topRatedMoviesList![index],
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
