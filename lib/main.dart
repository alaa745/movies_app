import 'package:flutter/material.dart';
import 'package:movies_app/presentation/home_screen/home_screen.dart';
import 'package:movies_app/presentation/home_screen/home_tab.dart';
import 'package:movies_app/presentation/movie_details_screen/movie_details_screen.dart';
import 'package:movies_app/presentation/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.routeName,
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFF121312),
          navigationBarTheme: NavigationBarThemeData(
            labelTextStyle: WidgetStatePropertyAll(
              TextStyle(color: Colors.white),
            ),
          ),
        ),
        routes: {
          SplashScreen.routeName: (context) => SplashScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          MovieDetailsScreen.routeName: (context) => MovieDetailsScreen(),
        });
  }
}
