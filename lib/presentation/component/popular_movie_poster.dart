import 'package:flutter/material.dart';
import 'package:movies_app/presentation/component/poster_card_vertical.dart';

class PopularMoviePoster extends StatelessWidget {
  String posterPath, title, releaseDate, coverPath;
  double avgRating;
  PopularMoviePoster(
      {required this.avgRating,
      required this.posterPath,
      required this.releaseDate,
      required this.coverPath,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          'https://image.tmdb.org/t/p/w500/$coverPath',
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
              PosterCardVertical(imagePath: posterPath),
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
                        title,
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
                        '$releaseDate $avgRating',
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
