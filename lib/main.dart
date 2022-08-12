import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cryptmark/pages/market_page.dart';
import 'package:cryptmark/routing/router.dart';
import 'package:cryptmark/states/coin_cubit.dart';
import 'package:cryptmark/theme/custom_theme.dart';
import 'package:cryptmark/theme/theme_model.dart';
import 'package:cryptmark/pages/home_page.dart';
import 'package:cryptmark/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Make status bar transparent
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
                  Expanded(
                    child: Image.asset("assets/images/logo.png",
                        width: 200, height: 200),
                  ),
                  Text(
                    "Cryptmark",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.lightGreen,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
              splashIconSize: 200,
              nextScreen: HomePage(
                themeNotifier: themeNotifier,
              ),
              splashTransition: SplashTransition.fadeTransition,
              backgroundColor: Colors.white,
            ),
          );
        }));
  }
}
