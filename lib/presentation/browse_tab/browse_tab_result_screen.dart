import 'package:flutter/material.dart';
import 'package:movies_app/domain/models/dtos/genre_list_dto.dart';
import 'package:movies_app/domain/models/dtos/result_dto.dart';
import 'package:movies_app/presentation/browse_tab/browse_tab_arguments.dart';
import 'package:movies_app/presentation/component/search_card.dart';

class BrowseTabResultScreen extends StatefulWidget {
  static const String routeName = 'BrowseTabResult';
  @override
  State<BrowseTabResultScreen> createState() => _BrowseTabResultScreenState();
}

class _BrowseTabResultScreenState extends State<BrowseTabResultScreen> {
  late List<MovieResultDto> moviesList;
  late BrowseTabArguments arguments;
  late GenreListDto genreList;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    arguments =
        ModalRoute.of(context)!.settings.arguments as BrowseTabArguments;
    moviesList = arguments.moviesList;
    genreList = arguments.genreList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Container(
            //   padding: EdgeInsets.only(left: 20.0, right: 20),
            //   margin: EdgeInsets.only(top: 15),
            //   child: Column(
            //     children: [
            //       SearchBar(
            //         backgroundColor: const WidgetStatePropertyAll(
            //           Color(0xFF514F4F),
            //         ),
            //         side: const WidgetStatePropertyAll(
            //           BorderSide(color: Colors.white),
            //         ),
            //         textStyle: const WidgetStatePropertyAll(TextStyle(
            //           color: Colors.white,
            //         )),
            //         leading: const Icon(
            //           Icons.search_rounded,
            //           color: Colors.white,
            //         ),
            //         onSubmitted: (value) {
            //           viewmodel.searchMovie(value);
            //         },
            //       ),
            //     ],
            //   ),
            // ),
            moviesList.isNotEmpty
                ? Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 15),
                      child: ListView.builder(
                        itemCount: moviesList.length,
                        itemBuilder: (context, index) {
                          return SearchCard(
                            movieResultDto: moviesList[index],
                            genreList: genreList,
                          );
                        },
                      ),
                    ),
                  )
                : Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/no_movies.png',
                          width: 80,
                          height: 90,
                        ),
                        Text(
                          'No movies found',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFFCBCBCB),
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
