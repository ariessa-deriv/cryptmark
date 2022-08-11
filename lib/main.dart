import 'dart:convert';
import 'package:cryptmark/models/coin_model.dart';
import 'package:cryptmark/routing/router.dart';
import 'package:cryptmark/services/coin_service.dart';
import 'package:cryptmark/pages/coin_detail_page.dart';
import 'package:cryptmark/pages/watchlist_page.dart';
import 'package:cryptmark/states/coin_cubit.dart';
import 'package:cryptmark/theme/custom_theme.dart';
import 'package:cryptmark/theme/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:cryptmark/pages/home_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:rive_splash_screen/rive_splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(BlocProvider(
    create: ((context) => CoinCubit()),
    child: const MyApp(),
  ));
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
              title: 'Cryptmark',
              theme: themeNotifier.isDark
                  ? ThemeData.dark()
                  : CustomTheme.lightTheme,
              home: SplashScreen.navigate(
                name: "assets/rive/splash.riv",
                next: (_) => HomePage(),
                until: () => Future.delayed(Duration(seconds: 5)),
                startAnimation: "start",
                endAnimation: "end",
                backgroundColor: Colors.white,
              ));
        }));
  }
}
