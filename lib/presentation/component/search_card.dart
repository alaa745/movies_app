import 'package:flutter/material.dart';
import 'package:movies_app/domain/models/dtos/result_dto.dart';
import 'package:movies_app/presentation/movie_details_screen/movie_details_screen.dart';
import 'package:movies_app/presentation/movie_details_screen/movie_details_screen_arguments.dart';

class SearchCard extends StatelessWidget {
  MovieResultDto movieResultDto;
  SearchCard({required this.movieResultDto});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        MovieDetailsScreen.routeName,
        arguments: MovieDetailsScreenArguments(movieResultDto: movieResultDto),
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: movieResultDto.backdropPath != null
                  ? Image.network(
                      'https://image.tmdb.org/t/p/w500/${movieResultDto.backdropPath}',
                      width: 140,
                      height: 90,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'images/placeholder.jpg',
                      width: 140,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
            ),
            Container(
              height: 90,
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 240,
                    child: Text(
                      movieResultDto.title!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    movieResultDto.releaseDate!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFCBCBCB),
                    ),
                  ),
                  Text(
                    movieResultDto.voteAverage!.toString(),
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
}
