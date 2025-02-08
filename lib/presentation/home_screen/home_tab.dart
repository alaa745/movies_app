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
import 'package:movies_app/presentation/home_screen/home_screen_state.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("home");
    final args =
        ModalRoute.of(context)?.settings.arguments as HomeScreenArguments;
    return BlocProvider(
      create: (context) => HomeScreenViewmodel()..getPopularMovies(),
      child: Scaffold(
        backgroundColor: Color(0xFF121312),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<HomeScreenViewmodel, HomeScreenState>(
                    builder: (context, state) {
                  if (state.isLoading) {
                    return PosterCoverShimmerCard();
                  } else if (state.errorMessage.isNotEmpty) {
                    if (Platform.isIOS) {
                      DialogUtils.showDialogIos(
                          alertMsg: 'Fail',
                          alertContent: state.errorMessage,
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
                          alertContent: state.errorMessage,
                          // onAction: () {
                          //   Navigator.pop(context);
                          //   Navigator.pushReplacementNamed(context, 'Login',
                          //       arguments: LoginScreenArguments(args!.countriesFlagsDto));
                          // },
                          statusCode: state.statusCode,
                          context: context);
                    }
                  }
                  return PopularMoviePoster(
                    movieResultDto: state.popularMovies.first,
                    genreListDto: args.genreListDto,
                  );

                  // Add this line to return a default widget
                }),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  color: Color(0xFF282A28),
                  width: MediaQuery.sizeOf(context).width,
                  // height: 230,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                        child:
                            BlocBuilder<HomeScreenViewmodel, HomeScreenState>(
                          builder: (context, state) {
                            if (state.isNowPlayingLoading) {
                              return ListView.builder(
                                itemCount: 5,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    ShimmerPosterCardVertical(),
                              );
                            } else if (state.errorMessage.isNotEmpty) {
                              if (Platform.isIOS) {
                                DialogUtils.showDialogIos(
                                    alertMsg: 'Fail',
                                    alertContent: state.errorMessage,
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
                                    alertContent: state.errorMessage,
                                    // onAction: () {
                                    //   Navigator.pop(context);
                                    //   Navigator.pushReplacementNamed(context, 'Login',
                                    //       arguments: LoginScreenArguments(args!.countriesFlagsDto));
                                    // },
                                    statusCode: state.statusCode,
                                    context: context);
                              }
                            }
                            return ListView.builder(
                              itemCount: state.nowPlayingMovies.length,
                              padding: EdgeInsets.only(left: 10, right: 20),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => Container(
                                margin: EdgeInsets.only(right: 10),
                                child: PosterCardVertical(
                                    height: 170,
                                    genreListDto: args.genreListDto,
                                    // iconWidth: 20,
                                    movieResultDto:
                                        state.nowPlayingMovies[index]),
                              ),
                            );
                            // Add this line to return a default widget
                          },
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
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                        child:
                            BlocBuilder<HomeScreenViewmodel, HomeScreenState>(
                          builder: (context, state) {
                            if (state.isRecommendedLoading) {
                              return ListView.builder(
                                itemCount: 5,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    ShimmerPosterCardVertical(),
                              );
                            } else if (state.errorMessage.isNotEmpty) {
                              if (Platform.isIOS) {
                                DialogUtils.showDialogIos(
                                    alertMsg: 'Fail',
                                    alertContent: state.errorMessage,
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
                                    alertContent: state.errorMessage,
                                    // onAction: () {
                                    //   Navigator.pop(context);
                                    //   Navigator.pushReplacementNamed(context, 'Login',
                                    //       arguments: LoginScreenArguments(args!.countriesFlagsDto));
                                    // },
                                    statusCode: state.statusCode,
                                    context: context);
                              }
                            }
                            return ListView.builder(
                              itemCount: state.topRatedMovies.length,
                              padding:
                                  const EdgeInsets.only(left: 10, right: 20),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => Container(
                                margin: EdgeInsets.only(bottom: 5, right: 10),
                                child: TopRatedCard(
                                  // height: 170,
                                  // iconWidth: 20,
                                  genreListDto: args.genreListDto,
                                  movieResultDto: state.topRatedMovies[index],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
