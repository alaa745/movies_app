import 'package:flutter/material.dart';
import 'package:movies_app/domain/models/dtos/genre_dto.dart';

class CategoryCard extends StatelessWidget {
  GenreDto genreDto;
  Function onTap;
  CategoryCard({required this.genreDto, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      onTap: () => onTap(genreDto.id.toString()),
      child: Container(
        margin: EdgeInsets.only(right: 13),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'images/category_card.png',
                // width: 160,
                // height: 90,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              genreDto.name!,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
