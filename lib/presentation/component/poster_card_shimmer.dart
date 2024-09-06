import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPosterCardVertical extends StatelessWidget {
  const ShimmerPosterCardVertical({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(13),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 200,
              width: 130,
              color: Colors.grey[300],
            ),
          ),
        ),
        // Bookmark icon shimmer
        ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(13)),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 30,
              height: 40,
              color: Colors.grey[300],
            ),
          ),
        ),
      ],
    );
  }
}
