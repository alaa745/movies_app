import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:movies_app/domain/models/customException/database_exception.dart';
import 'package:movies_app/domain/models/dtos/genre_list_dto.dart';
import 'package:movies_app/domain/models/dtos/result_dto.dart';
import 'package:movies_app/presentation/movie_details_screen/movie_details_screen.dart';
import 'package:movies_app/presentation/movie_details_screen/movie_details_screen_arguments.dart';
import 'package:movies_app/presentation/watch_list_screen/watch_list_tab_viewmodel.dart';
import 'package:provider/provider.dart';

class PosterCardVertical extends StatefulWidget {
  MovieResultDto movieResultDto;
  GenreListDto genreListDto;
  double? height, iconWidth;
  PosterCardVertical(
      {required this.movieResultDto,
      this.height,
      this.iconWidth,
      required this.genreListDto});

  @override
  State<PosterCardVertical> createState() => _PosterCardVerticalState();
}

class _PosterCardVerticalState extends State<PosterCardVertical> {
  late bool isSaved;
  late WatchListTabViewmodel watchListTabViewmodel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    watchListTabViewmodel =
        Provider.of<WatchListTabViewmodel>(context, listen: false);
    // getMovies();
  }

  void getMovies() async {
    await watchListTabViewmodel.getMovies();
  }

  @override
  Widget build(BuildContext context) {
    isSaved = watchListTabViewmodel.movies
        .any((movie) => movie.id == widget.movieResultDto.id);
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        MovieDetailsScreen.routeName,
        arguments: MovieDetailsScreenArguments(
          movieResultDto: widget.movieResultDto,
          genreListDto: widget.genreListDto,
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
                'https://image.tmdb.org/t/p/w500/${widget.movieResultDto.posterPath}',
                height: widget.height ?? 200,
                // width: 130,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
              child: InkWell(
                onTap: () => _toggleSaved(),
                child: Image.asset(
                  isSaved
                      ? 'images/saved_icon.png'
                      : 'images/bookmark_icon.png',
                  width: widget.iconWidth ?? 30,
                  height: 40,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _toggleSaved() async {
    try {
      if (!isSaved) {
        await watchListTabViewmodel.insertMovie(MovieResultDto(
          id: widget.movieResultDto.id,
          title: widget.movieResultDto.title,
          releaseDate: widget.movieResultDto.releaseDate,
          backdropPath: widget.movieResultDto.backdropPath,
          voteAverage: widget.movieResultDto.voteAverage,
          overview: widget.movieResultDto.overview,
          genreIds: widget.movieResultDto.genreIds,
          posterPath: widget.movieResultDto.posterPath,
        ));
      } else {
        await watchListTabViewmodel.deleteMovie(widget.movieResultDto.id!);
      }
    } on DatabaseCustomException catch (e) {
      print('errorrrrrrrrrrrrrrrr ');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
    setState(() {
      isSaved = !isSaved;
    });
  }
}
