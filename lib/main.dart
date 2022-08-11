import 'dart:convert';
import 'package:animated_splash_screen/animated_splash_screen.dart';
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
              home: AnimatedSplashScreen(
                duration: 3000,
                splash: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      scale: 4,
                    ),
                    Text(
                      "Cryptmark",
                      style: TextStyle(fontSize: 20, color: Colors.lightGreen),
                    )
                  ],
                ),
                nextScreen: HomePage(),
                splashTransition: SplashTransition.fadeTransition,
                backgroundColor: Colors.white,
              ));
        }));
  }
}
