import 'dart:convert';
import 'package:cryptmark/models/coin_model.dart';
import 'package:cryptmark/routing/router.dart';
import 'package:cryptmark/services/coin_service.dart';
import 'package:cryptmark/pages/coin_detail_page.dart';
import 'package:cryptmark/pages/watchlist_page.dart';
import 'package:cryptmark/theme/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:cryptmark/pages/home_page.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ThemeModel(),
        child: Consumer(builder: (context, ThemeModel themeNotifier, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              onGenerateRoute: (settings) => generateRoute(settings),
              initialRoute: homeRoute,
              title: 'Flutter Demo',
              theme:
                  themeNotifier.isDark ? ThemeData.dark() : ThemeData.light(),
              home: HomePage());
        }));
  }
}
