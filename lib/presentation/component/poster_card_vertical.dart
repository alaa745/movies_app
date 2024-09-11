import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:movies_app/domain/models/dtos/genre_list_dto.dart';
import 'package:movies_app/domain/models/dtos/result_dto.dart';
import 'package:movies_app/presentation/movie_details_screen/movie_details_screen.dart';
import 'package:movies_app/presentation/movie_details_screen/movie_details_screen_arguments.dart';

class PosterCardVertical extends StatelessWidget {
  MovieResultDto movieResultDto;
  GenreListDto genreListDto;
  double? height, iconWidth;
  PosterCardVertical(
      {required this.movieResultDto,
      this.height,
      this.iconWidth,
      required this.genreListDto});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        MovieDetailsScreen.routeName,
        arguments: MovieDetailsScreenArguments(
          movieResultDto: movieResultDto,
          genreListDto: genreListDto,
        ),
      ),
      child: Container(
        // margin: EdgeInsets.only(right: 10),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://image.tmdb.org/t/p/w500/${movieResultDto.posterPath}',
                height: height ?? 200,
                // width: 130,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
              child: Image.asset(
                'images/bookmark_icon.png',
                width: iconWidth ?? 30,
                height: 40,
              ),
            )
          ],
        ),
      ),
    );
  }
}
