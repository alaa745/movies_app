import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/domain/models/dtos/result_dto.dart';
import 'package:movies_app/presentation/component/search_card.dart';
import 'package:movies_app/presentation/search_tab/search_tab_viewmodel.dart';
import 'package:movies_app/presentation/utils/dialog_utils.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  bool isLoading = true;
  List<MovieResultDto> searchedMovies = [];
  late SearchTabViewmodel viewmodel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewmodel = SearchTabViewmodel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: viewmodel,
      listener: (context, state) {
        if (state is SearchTabLoadingState) {
          isLoading = true;
        } else if (state is SearchTabFailState) {
          print('status code ${state.statusCode}');
          if (Platform.isIOS) {
            DialogUtils.showDialogIos(
                alertMsg: 'Fail',
                alertContent: state.failMessage,
                statusCode: state.statusCode,
                // onAction: () {
                //   Navigator.pop(context);
                //   Navigator.pushReplacementNamed(context, 'Login',
                //       arguments: LoginScreenArguments(args!.countriesFlagsDto));
                // },
                context: context);
          } else {
            DialogUtils.showDialogAndroid(
                alertMsg: 'Fail',
                alertContent: state.failMessage,
                // onAction: () {
                //   Navigator.pop(context);
                //   Navigator.pushReplacementNamed(context, 'Login',
                //       arguments: LoginScreenArguments(args!.countriesFlagsDto));
                // },
                statusCode: state.statusCode,
                context: context);
          }
        }
      },
      listenWhen: (previous, current) {
        if (current is SearchTabLoadingState || current is SearchTabFailState) {
          return true;
        }
        if (previous is SearchTabLoadingState) {
          isLoading = false;
        }
        return false;
      },
      builder: (context, state) {
        if (state is SearchTabSuccessState) {
          isLoading = false;
          searchedMovies = state.moviesList;
        }
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20.0, right: 20),
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
                        onSubmitted: (value) {
                          viewmodel.searchMovie(value);
                        },
                      ),
                    ],
                  ),
                ),
                searchedMovies.isNotEmpty
                    ? Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 15),
                          child: ListView.builder(
                            itemCount: searchedMovies.length,
                            itemBuilder: (context, index) {
                              return SearchCard(
                                  movieResultDto: searchedMovies[index]);
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
      },
    );
  }
}
