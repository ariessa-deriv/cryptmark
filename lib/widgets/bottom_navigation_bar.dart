import 'package:cryptmark/pages/explore_page.dart';
import 'package:cryptmark/pages/home_page.dart';
import 'package:cryptmark/pages/watchlist_page.dart';
import 'package:cryptmark/routing/router.dart';
import 'package:cryptmark/theme/theme_model.dart';
import 'package:cryptmark/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final ThemeModel themeNotifier;
  const BottomNavBar({Key? key, required this.themeNotifier}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

// TODO: Put colour at text and icon for selected index
// to differentiate between selected and non selected index
class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  List<Widget> _tabs = [
    HomePage(),
    SearchPage(searchCoin: ""),
    WatchlistPage(),
  ];
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'HomePage',
      style: optionStyle,
    ),
    Text(
      'Explore',
      style: optionStyle,
    ),
    Text(
      'Watchlist',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      // if (index == 0) {
      //   Navigator.pushNamed(context, homeRoute);
      //   Navigator.pushReplacement(
      //       context,
      //       PageRouteBuilder(
      //           pageBuilder: (context, animation, secondaryAnimation) =>
      //               HomePage(),
      //           transitionDuration: Duration.zero,
      //           reverseTransitionDuration: Duration.zero));
      // }

      // if (index == 1) {
      //   Navigator.pushNamed(context, searchRoute);
      //   Navigator.pushReplacement(
      //       context,
      //       PageRouteBuilder(
      //           pageBuilder: (context, animation, secondaryAnimation) =>
      //               const SearchPage(
      //                 searchCoin: '',
      //               ),
      //           transitionDuration: Duration.zero,
      //           reverseTransitionDuration: Duration.zero));
      // }

      // if (index == 2) {
      //   Navigator.pushNamed(context, watchlistRoute);
      //   Navigator.pushReplacement(
      //       context,
      //       PageRouteBuilder(
      //           pageBuilder: (context, animation, secondaryAnimation) =>
      //               WatchlistPage(),
      //           transitionDuration: Duration.zero,
      //           reverseTransitionDuration: Duration.zero));
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          // backgroundColor: widget.themeNotifier.isDark
          //     ? Colors.grey.shade800
          //     : Colors.grey.shade200,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.show_chart, color: Colors.grey.shade500),
              label: 'Market',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                // color: widget.themeNotifier.isDark
                //     ? Colors.grey.shade200
                //     : Colors.grey.shade800,
              ),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.star_border_outlined,
                // color: widget.themeNotifier.isDark
                //     ? Colors.grey.shade200
                //     : Colors.grey.shade800,
              ),
              label: 'Watchlist',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.green,
          onTap: _onItemTapped,
        ),
        body: Center(
          child: _tabs[_selectedIndex],
        ));
  }
}
