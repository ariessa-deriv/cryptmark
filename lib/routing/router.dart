import 'package:cryptmark/pages/coin_detail_page.dart';
import 'package:cryptmark/pages/home_page.dart';
import 'package:cryptmark/pages/watchlist_page.dart';
import 'package:flutter/material.dart';

const String homeRoute = '/';
const String watchlistRoute = 'watchlist';
const String coindetailRoute = 'coindetail';

Route generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case homeRoute:
      return MaterialPageRoute(builder: (_) => const HomePage());
    // case searchRoute:
    //   return MaterialPageRoute(builder: (_) => const SearchPage());
    case watchlistRoute:
      return MaterialPageRoute(builder: (_) => const WatchlistPage());
    case coindetailRoute:
      final args = settings.arguments as Map<dynamic, dynamic>;
      return MaterialPageRoute(builder: (_) => CoinDetail(coinDetail: args));
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}
