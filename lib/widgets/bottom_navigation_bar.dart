import 'package:cryptmark/routing/router.dart';
import 'package:cryptmark/theme/theme_model.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final ThemeModel themeNotifier;
  const BottomNavBar({Key? key, required this.themeNotifier}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

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
      'Watchlist',
      style: optionStyle,
    ),
    Text(
      'Search',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      if (index == 0) {
        Navigator.pushNamed(context, homeRoute, arguments: 'Data from home');
      }

      if (index == 1) {
        Navigator.pushNamed(context, watchlistRoute,
            arguments: 'Data from home');
      }
      if (index == 2) {
        Navigator.pushNamed(context, searchRoute,
            arguments: 'Data from home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: widget.themeNotifier.isDark
          ? Colors.grey.shade800
          : Colors.grey.shade200,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.show_chart, color: Colors.grey.shade500),
          label: 'Market',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.star_border_outlined,
            color: widget.themeNotifier.isDark
                ? Colors.grey.shade200
                : Colors.grey.shade800,
          ),
          label: 'Watchlist',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
            color: Colors.grey.shade700,
          ),
          label: 'Search',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.grey,
      onTap: _onItemTapped,
    );
  }
}
