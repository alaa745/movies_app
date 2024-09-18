import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/presentation/browse_tab/browse_tab.dart';
import 'package:movies_app/presentation/home_screen/home_tab.dart';
import 'package:movies_app/presentation/search_tab/search_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'Home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var selectedIndex = 0;
  var isSelected = false, isAddSelected = false;
  var tabs = [HomeTab(), SearchTab(), BrowseTab()];
  @override
  Widget build(BuildContext context) {
    // args = ModalRoute.of(context)!.settings.arguments as HomeScreenArguments;

    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(
    //       systemNavigationBarColor: Colors.white,
    //       statusBarColor: Colors.transparent,
    //       statusBarIconBrightness: Brightness.dark),
    // );
    return Scaffold(
        body: tabs[selectedIndex],
        bottomNavigationBar: NavigationBar(
          height: 70,
          animationDuration: Duration(milliseconds: 1000),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          indicatorColor: Colors.transparent,
          // labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          selectedIndex: selectedIndex,
          onDestinationSelected: (value) {
            selectedIndex = value;
            setState(() {});
          },
          destinations: const [
            const NavigationDestination(
              icon: ImageIcon(
                AssetImage('images/home_icon.png'),
                // size: 25,
                // color: Theme.of(context).primaryColor,
                color: Color(0xFFFFFFFF),
              ),
              selectedIcon: ImageIcon(
                AssetImage('images/home_icon.png'),
                semanticLabel: 'Home',
                // size: 25,
                color: Color(0xFFFFBB3B),
              ),
              label: 'Home',
            ),
            const NavigationDestination(
              icon: ImageIcon(
                AssetImage('images/search_icon.png'),
                // size: 25,
                // color: Theme.of(context).primaryColor,
                color: Color(0xFFFFFFFF),
              ),
              selectedIcon: ImageIcon(
                AssetImage('images/search_icon.png'),
                // size: 25,
                color: Color(0xFFFFBB3B),
              ),
              label: 'Search',
            ),
            const NavigationDestination(
              icon: ImageIcon(
                AssetImage('images/brows_icon.png'),
                // size: 25,
                color: Color(0xFFFFFFFF),
              ),
              selectedIcon: ImageIcon(
                AssetImage('images/brows_icon.png'),
                color: Color(0xFFFFBB3B),

                // size: 25,
                // color: Color(0xFFADADAD),
              ),
              label: 'Browse',
            ),
            const NavigationDestination(
              icon: ImageIcon(
                AssetImage('images/watchlist_icon.png'),
                // size: 25,
                // color: Theme.of(context).primaryColor,
                color: Color(0xFFFFFFFF),
              ),
              selectedIcon: ImageIcon(
                AssetImage('images/watchlist_icon.png'),
                color: Color(0xFFFFBB3B),

                // size: 25,
                // color: Theme.of(context).primaryColor,
              ),
              label: 'Watchlist',
            ),
          ],
        ));
  }
}
