import 'dart:ui';
import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    //1
    return ThemeData(
      //2
      appBarTheme: AppBarTheme(
          shadowColor: Colors.white,
          backgroundColor: Color(0xFFedf0f2),
          iconTheme: IconThemeData(color: Color(0xff000000)),
          titleTextStyle: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xFFedf0f2),
          selectedItemColor: Colors.black,
          selectedIconTheme: IconThemeData(color: Colors.black),
          unselectedItemColor: Colors.grey,
          unselectedIconTheme: IconThemeData(color: Colors.grey)),

      scaffoldBackgroundColor: Color(0xFFeeeeeee),
      fontFamily: 'Montserrat', //3
    );
  }
}
