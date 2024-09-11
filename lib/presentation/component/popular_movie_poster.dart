import 'package:flutter/material.dart';
import 'package:movies_app/domain/models/dtos/genre_list_dto.dart';
import 'package:movies_app/domain/models/dtos/result_dto.dart';
import 'package:movies_app/presentation/component/poster_card_vertical.dart';

class PopularMoviePoster extends StatelessWidget {
  MovieResultDto movieResultDto;
  GenreListDto genreListDto;
  PopularMoviePoster({
    required this.movieResultDto,
    required this.genreListDto,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          'https://image.tmdb.org/t/p/w500/${movieResultDto.backdropPath}',
          width: MediaQuery.sizeOf(context).width,
          height: 225,
          fit: BoxFit.cover,
        ),
        Container(
          margin: EdgeInsets.only(top: 100, left: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PosterCardVertical(
                movieResultDto: movieResultDto,
                genreListDto: genreListDto,
              ),
              Container(
                margin: EdgeInsets.only(
                    bottom: MediaQuery.sizeOf(context).height * .02, left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // margin: EdgeInsets.only(
                      //     bottom:
                      //         MediaQuery.sizeOf(context).height *
                      //             .035,
                      //     left: 12),
                      child: Text(
                        '${movieResultDto.title}',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    Container(
                      // margin: EdgeInsets.only(
                      //     bottom:
                      //         MediaQuery.sizeOf(context).height *
                      //             .035,
                      //     left: 12),
                      child: Text(
                        '${movieResultDto.releaseDate} ${movieResultDto.voteAverage}',
                        style:
                            TextStyle(color: Color(0xFFB5B4B4), fontSize: 12),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
