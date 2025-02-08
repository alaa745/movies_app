import 'package:flutter/material.dart';
import 'package:movies_app/domain/models/customException/database_exception.dart';
import 'package:movies_app/domain/models/dtos/genre_list_dto.dart';
import 'package:movies_app/domain/models/dtos/result_dto.dart';
import 'package:movies_app/presentation/movie_details_screen/movie_details_screen.dart';
import 'package:movies_app/presentation/movie_details_screen/movie_details_screen_arguments.dart';
import 'package:movies_app/presentation/watch_list_screen/watch_list_tab_viewmodel.dart';
import 'package:provider/provider.dart';

class SearchCard extends StatefulWidget {
  MovieResultDto movieResultDto;
  GenreListDto genreList;
  Function? onDelete;
  SearchCard(
      {required this.movieResultDto, required this.genreList, this.onDelete});

  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  late WatchListTabViewmodel watchListTabViewmodel;
  late bool isSaved;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    watchListTabViewmodel =
        Provider.of<WatchListTabViewmodel>(context, listen: false);
    // getMovies();
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
          genreListDto: widget.genreList,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.topLeft,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: widget.movieResultDto.backdropPath != null
                      ? Image.network(
                          'https://image.tmdb.org/t/p/w500/${widget.movieResultDto.backdropPath}',
                          width: 170,
                          height: 110,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'images/placeholder.jpg',
                          width: 170,
                          height: 110,
                          fit: BoxFit.cover,
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
                      height: 40,
                    ),
                  ),
                )
              ],
            ),
            Container(
              height: 110,
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 185,
                    child: Text(
                      widget.movieResultDto.title!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    widget.movieResultDto.releaseDate!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFCBCBCB),
                    ),
                  ),
                  Text(
                    widget.movieResultDto.voteAverage!.toString(),
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFCBCBCB),
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
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
        widget.onDelete!(widget.movieResultDto.id);
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
