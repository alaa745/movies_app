import 'package:flutter/material.dart';
import 'package:movies_app/domain/models/dtos/genre_list_dto.dart';
import 'package:movies_app/domain/models/dtos/result_dto.dart';
import 'package:movies_app/presentation/browse_tab/browse_tab_arguments.dart';
import 'package:movies_app/presentation/component/search_card.dart';
import 'package:movies_app/presentation/home_screen/home_screen_arguments.dart';
import 'package:movies_app/presentation/watch_list_screen/watch_list_tab_viewmodel.dart';
import 'package:provider/provider.dart';

class WatchListTab extends StatefulWidget {
  @override
  State<WatchListTab> createState() => _BrowseTabResultScreenState();
}

class _BrowseTabResultScreenState extends State<WatchListTab> {
  late List<MovieResultDto> moviesList;
  List<MovieResultDto> filteredMoviesList = [];
  late HomeScreenArguments arguments;
  late GenreListDto genreList;
  late WatchListTabViewmodel viewmodel;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    arguments =
        ModalRoute.of(context)!.settings.arguments as HomeScreenArguments;
    genreList = arguments.genreListDto;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewmodel = Provider.of<WatchListTabViewmodel>(context, listen: false);
    // viewmodel.getMovies();
    _fetchMovies();
  }

  void _fetchMovies() async {
    await viewmodel.getMovies();
    setState(() {
      moviesList = viewmodel.movies;
      filteredMoviesList.addAll(moviesList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              margin: EdgeInsets.only(top: 15),
              child: Column(
                children: [
                  SearchBar(
                    backgroundColor: const WidgetStatePropertyAll(
                      Color(0xFF514F4F),
                    ),
                    side: const WidgetStatePropertyAll(
                      BorderSide(color: Colors.white),
                    ),
                    textStyle: const WidgetStatePropertyAll(TextStyle(
                      color: Colors.white,
                    )),
                    leading: const Icon(
                      Icons.search_rounded,
                      color: Colors.white,
                    ),
                    onChanged: (value) {
                      filteredMoviesList.clear();
                      if (value.trim().isNotEmpty) {
                        print('not');
                        filteredMoviesList = moviesList
                            .where((movie) => movie.title!
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                            .toList();
                        // for (var movie in moviesList) {
                        //   print('y');
                        //   if (movie.title!
                        //       .toLowerCase()
                        //       .startsWith(value.toLowerCase())) {
                        //     print('yess');
                        //     filteredMoviesList.add(movie);
                        //   }
                        // }
                      } else {
                        filteredMoviesList.addAll(viewmodel.movies);
                      }
                      setState(() {});
                      // viewmodel.searchMovie(value);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 15),
                child: ListView.builder(
                  itemCount: filteredMoviesList.length,
                  itemBuilder: (context, index) {
                    final movies = filteredMoviesList;
                    return SearchCard(
                      movieResultDto: movies[index],
                      genreList: genreList,
                      onDelete: (id) {
                        filteredMoviesList
                            .removeWhere((movie) => movie.id == id);
                        print('deletee');
                        setState(() {});
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMoviesEmpty() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/no_movies.png',
            width: 80,
            height: 90,
          ),
          const Text(
            'No movies found',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFFCBCBCB),
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
