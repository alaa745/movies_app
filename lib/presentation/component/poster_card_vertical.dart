import 'dart:ffi';

import 'package:flutter/material.dart';

class PosterCardVertical extends StatelessWidget {
  String imagePath;
  double? height, iconWidth;
  PosterCardVertical({required this.imagePath, this.height, this.iconWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(right: 10),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              'https://image.tmdb.org/t/p/w500/$imagePath',
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
    );
  }
}
