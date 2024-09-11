import 'package:flutter/material.dart';
import 'package:movies_app/data/api/api_manager.dart';
import 'package:movies_app/domain/models/customException/custom_exception.dart';
import 'package:movies_app/domain/models/dtos/genre_list_dto.dart';
import 'package:movies_app/presentation/home_screen/home_screen.dart';
import 'package:movies_app/presentation/home_screen/home_tab.dart';
import 'package:movies_app/presentation/home_screen/home_screen_arguments.dart';
import 'package:movies_app/presentation/utils/dialog_utils.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = 'SplashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ApiManager apiManager = ApiManager();
  GenreListDto? genreListDto;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getGenreList();
      Navigator.pushReplacementNamed(
        context,
        HomeScreen.routeName,
        arguments: HomeScreenArguments(genreListDto: genreListDto!),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        'images/splash_image.png',
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Future<GenreListDto?> getGenreList() async {
    try {
      var response = await apiManager.getGenresList();
      var genreList = response.toDto();
      genreListDto = genreList;
    } on ServerErrorException catch (e) {
      DialogUtils.showDialogIos(
          context: context, alertMsg: 'Fail', alertContent: e.errorMessage);
    } on Exception catch (e) {
      DialogUtils.showDialogIos(
          context: context, alertMsg: 'Fail', alertContent: e.toString());
    }
    return genreListDto;
  }
}
