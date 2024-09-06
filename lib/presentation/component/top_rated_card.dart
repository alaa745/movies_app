import 'dart:ffi';

import 'package:flutter/material.dart';

class TopRatedCard extends StatelessWidget {
  String imagePath;
  double advgRating;
  String date, title;
  TopRatedCard(
      {required this.imagePath,
      required this.advgRating,
      required this.date,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.5,
      color: Color(0xFF282A28),
      shadowColor: Colors.black,
      child: Container(
        // color: Colors.amber,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topLeft,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500/$imagePath',
                    height: 130,
                    fit: BoxFit.fill,
                    width: 110,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
                  child: Image.asset(
                    'images/bookmark_icon.png',
                    width: 30,
                    height: 40,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'images/review_icon.png',
                        width: 15,
                        height: 15,
                      ),
                      Text(
                        ' $advgRating',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  Container(
                    width: 110,
                    child: Text(
                      '$title',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    '$date',
                    style: TextStyle(
                        color: Color(0xFFB5B4B4),
                        fontSize: 11,
                        fontWeight: FontWeight.w500),
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
