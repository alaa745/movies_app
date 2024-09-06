import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PosterCoverShimmerCard extends StatelessWidget {
  const PosterCoverShimmerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Shimmer for the backdrop image
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            height: 225,
            color: Colors.grey[300],
          ),
        ),
        // Positioned container for poster and text
        Container(
          margin: EdgeInsets.only(top: 100, left: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Shimmer for poster image
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 100,
                  height: 150,
                  color: Colors.grey[300],
                ),
              ),
              // Space for title and details
              Container(
                margin: EdgeInsets.only(
                    bottom: MediaQuery.sizeOf(context).height * .02, left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Shimmer for title
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 200,
                        height: 24,
                        color: Colors.grey[300],
                      ),
                    ),
                    SizedBox(height: 8),
                    // Shimmer for release date and rating
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 100,
                        height: 16,
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
