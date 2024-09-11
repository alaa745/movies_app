import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/domain/models/dtos/genre_dto.dart';
import 'package:movies_app/domain/models/dtos/result_dto.dart';
import 'package:movies_app/presentation/component/poster_card_shimmer.dart';
import 'package:movies_app/presentation/component/poster_card_vertical.dart';
import 'package:movies_app/presentation/component/top_rated_card.dart';
import 'package:movies_app/presentation/movie_details_screen/movie_details_screen_arguments.dart';
import 'package:movies_app/presentation/movie_details_screen/movie_details_viewmodel.dart';
import 'package:movies_app/presentation/utils/dialog_utils.dart';

class MovieDetailsScreen extends StatefulWidget {
  static const String routeName = 'MovieDetails';
  const MovieDetailsScreen({super.key});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late MovieDetailsScreenArguments args;
  late MovieResultDto movieResultDto;
  List<int>? genreIds = [];
  List<GenreDto>? categoriesList = [];
  List<GenreDto>? filteredGenreList = [];
  late MovieDetailsViewmodel viewmodel;
  bool isMoreLikeThisLoading = true;
  List<MovieResultDto>? moreLikeTHisMoviesList = [];
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    args = ModalRoute.of(context)?.settings.arguments
        as MovieDetailsScreenArguments;
    movieResultDto = args.movieResultDto;
    categoriesList = args.genreListDto!.genres;
    genreIds = movieResultDto.genreIds;
    getGenre();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewmodel = MovieDetailsViewmodel();
  }

  @override
  Widget build(BuildContext context) {
    print('filtered ${filteredGenreList}');
    print('listt $categoriesList');
    print('categories: ${movieResultDto.genreIds}');
    return BlocConsumer(
      bloc: viewmodel..getMoreLikeThis(movieResultDto.id!),
      listener: (context, state) {
        if (state is GetMoreLikeThisLoadingState) {
          print('loadiiiiiing');
          isMoreLikeThisLoading = true;
        } else if (state is GetMoreLikeThisFailState) {
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
        if (current is GetMoreLikeThisLoadingState ||
            current is GetMoreLikeThisFailState) {
          return true;
        }
        if (previous is GetMoreLikeThisLoadingState) {
          isMoreLikeThisLoading = false;
        }

        return false;
      },
      builder: (context, state) {
        if (state is GetMoreLikeThisSuccessState) {
          moreLikeTHisMoviesList = state.popularMoviesList;
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              '${movieResultDto.title}',
              style: TextStyle(color: Colors.white),
            ),
            iconTheme: IconThemeData(color: Colors.white),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  'https://image.tmdb.org/t/p/w500/${movieResultDto.backdropPath}',
                  width: MediaQuery.sizeOf(context).width,
                  height: 225,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      '${movieResultDto.title}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 5.0),
                  // margin: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    '${movieResultDto.releaseDate}',
                    style: TextStyle(
                      color: Color(0xFFB5B4B4),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 8.0, // Space between items horizontally
                    runSpacing: 8.0,
                    children: [
                      for (var genre in filteredGenreList!)
                        Container(
                          // height: 300,
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Color(0xFFCBCBCB))),
                          child: Center(
                            child: Text(
                              genre.name!,
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFFCBCBCB),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  // width: 400,
                  // color: Colors.amber,
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      PosterCardVertical(
                        movieResultDto: movieResultDto,
                        genreListDto: args.genreListDto!,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 150,
                              width: 275,
                              margin: EdgeInsets.only(bottom: 13),
                              child: Text(
                                '${movieResultDto.overview}',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  color: Color(0xFFCBCBCB),
                                  fontSize: 15,
                                  // fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Container(
                              // margin: EdgeInsets.only(top: 15),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'images/review_icon.png',
                                    width: 25,
                                    height: 25,
                                  ),
                                  Text(
                                    ' ${movieResultDto.voteAverage}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
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
                          'More Like This',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        height: 220,
                        padding: EdgeInsets.only(bottom: 10),
                        child: isMoreLikeThisLoading
                            ? ListView.builder(
                                itemCount: 5,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    ShimmerPosterCardVertical(),
                              )
                            : ListView.builder(
                                itemCount: moreLikeTHisMoviesList?.length,
                                padding: EdgeInsets.only(left: 10, right: 20),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => Container(
                                  margin:
                                      EdgeInsets.only(right: 10, bottom: 10),
                                  child: TopRatedCard(
                                    // height: 170,
                                    // iconWidth: 20,
                                    genreListDto: args.genreListDto!,
                                    movieResultDto:
                                        moreLikeTHisMoviesList![index],
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
        );
      },
    );
  }

  void getGenre() {
    print('object');
    print('genres $categoriesList');
    for (var genre in genreIds!) {
      for (var category in categoriesList!) {
        if (genre == category.id) {
          print('true');
          filteredGenreList?.add(category);
        }
      }
    }
  }
}
