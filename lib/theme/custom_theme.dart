import 'dart:ui';
import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    //1
    return ThemeData(
      //2
      appBarTheme: AppBarTheme(
          shadowColor: Colors.white,
          backgroundColor: Color(0xFFd1d9ff),
          iconTheme: IconThemeData(color: Color(0xff000000)),
          titleTextStyle: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xFFd1d9ff),
          selectedItemColor: Colors.black,
          selectedIconTheme: IconThemeData(color: Colors.black),
          unselectedItemColor: Color(0xff757de8),
          unselectedIconTheme: IconThemeData(color: Color(0xff757de8))),

      scaffoldBackgroundColor: Color(0xFFe8eaf6),
      fontFamily: 'Montserrat', //3
    );
  }
}
