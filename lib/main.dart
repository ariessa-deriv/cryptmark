import 'dart:convert';

import 'package:cryptmark/models/cryptmark_model.dart';
import 'package:cryptmark/routing/router.dart';
import 'package:cryptmark/services/cryptmark_service.dart';
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
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> test = [];

  Future<void> fetchAPi() async {
    CryptmarkService cryptmarkService = CryptmarkService();
    final Uri url = Uri(
      scheme: 'https',
      host: 'api.coingecko.com',
      path: 'api/v3/coins/markets',
      queryParameters: {
        'vs_currency': 'usd',
        'order': 'market_cap_desc',
        'per_page': '50',
        'page': '1',
        'price_change_percentage': '1h,24h,7d'
      },
    );
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var testResponse = jsonDecode(response.body);
      print(testResponse.runtimeType);
      test = testResponse;
      print(test[4]['id']);
    } else {
      throw Exception('Failed to load weather information.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  themeNotifier.isDark
                      ? themeNotifier.isDark = false
                      : themeNotifier.isDark = true;
                },
                icon: Icon(themeNotifier.isDark
                    ? Icons.nightlight_rounded
                    : Icons.wb_sunny))
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: fetchAPi,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
