import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/domain/models/dtos/genre_list_dto.dart';
import 'package:movies_app/presentation/browse_tab/browe_tab_viewmodel.dart';
import 'package:movies_app/presentation/browse_tab/browse_tab_arguments.dart';
import 'package:movies_app/presentation/browse_tab/browse_tab_result_screen.dart';
import 'package:movies_app/presentation/component/category_card.dart';
import 'package:movies_app/presentation/home_screen/home_screen_arguments.dart';
import 'package:movies_app/presentation/utils/dialog_utils.dart';

class BrowseTab extends StatefulWidget {
  const BrowseTab({super.key});

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  late BrowseTabViewmodel viewmodel;
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewmodel = BrowseTabViewmodel();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as HomeScreenArguments;
    GenreListDto genreList = args.genreListDto;

    return BlocConsumer(
      bloc: viewmodel,
      listenWhen: (previous, current) {
        if (current is BrowseTabLoadingState ||
            current is BrowseTabFailState ||
            current is BrowseTabSuccessState) {
          return true;
        }
        if (previous is BrowseTabLoadingState) {
          isLoading = false;
        }
        return false;
      },
      listener: (context, state) {
        if (state is BrowseTabLoadingState) {
          print('successsss');
          isLoading = true;
          CircularProgressIndicator(
            strokeWidth: 20,
          );
        } else if (state is BrowseTabFailState) {
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
        } else if (state is BrowseTabSuccessState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamed(
              context,
              BrowseTabResultScreen.routeName,
              arguments: BrowseTabArguments(
                state.moviesList,
                genreList,
              ),
            );
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Browse Category',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      itemCount: genreList.genres?.length,
                      padding: EdgeInsets.zero,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2 / 1.3,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                      ),
                      itemBuilder: (context, index) => CategoryCard(
                        genreDto: genreList.genres![index],
                        onTap: (genreId) {
                          viewmodel.filterMovieWithGenre(genreId);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
