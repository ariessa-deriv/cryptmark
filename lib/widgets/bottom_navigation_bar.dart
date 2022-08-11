import 'package:cryptmark/routing/router.dart';
import 'package:cryptmark/theme/theme_model.dart';
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
      if (index == 0) {
        Navigator.pushNamed(context, homeRoute);
      }

      if (index == 1) {
        Navigator.pushNamed(context, searchRoute);
      }

      if (index == 2) {
        Navigator.pushNamed(context, watchlistRoute);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.show_chart),
          activeIcon:Icon(Icons.show_chart_outlined),
          label: 'Market',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search,),
          activeIcon: Icon(Icons.search_outlined),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.star_border_outlined),
          activeIcon: Icon(Icons.star_outlined),
          label: 'Watchlist',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.grey,
      onTap: _onItemTapped,
    );
  }
}
