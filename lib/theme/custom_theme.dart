import 'dart:ui';
import 'package:flutter/material.dart';

// <color name="primaryColor">#fafafa</color>
// <color name="primaryLightColor">#ffffff</color>
// <color name="primaryDarkColor">#c7c7c7</color>
// <color name="primaryTextColor">#000000</color>

// <color name="primaryColor">#fafafa</color>
// <color name="primaryLightColor">#ffffff</color>
// <color name="primaryDarkColor">#c7c7c7</color>
// <color name="secondaryColor">#f5f5f5</color>
// <color name="secondaryLightColor">#ffffff</color>
// <color name="secondaryDarkColor">#c2c2c2</color>
// <color name="primaryTextColor">#000000</color>
// <color name="secondaryTextColor">#000000</color>

// TODO: Add remaining theme for both dark mode and light mode

// const PrimaryColor = const Color(0xFFedf0f2);
// const PrimaryColorLight = const Color(0xFFd1d9ff);
// const PrimaryColorDark = const Color(0xFFf79a8);
//
// const SecondaryColor = const Color(0xFF4db6ac);
// const SecondaryColorLight = const Color(0xFF82e9de);
// const SecondaryColorDark = const Color(0xFF00867d);
//
// const TextColor = ;

class CustomTheme {
  static ThemeData get lightTheme {
    //1
    return ThemeData(
      //2
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFFedf0f2),
        iconTheme: IconThemeData(
            color: Color(0xff000000)
        ),
          titleTextStyle: TextStyle(
              fontSize: 18,
          color: Colors.black
      )
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Color(0xFFedf0f2),

        selectedItemColor: Colors.black,
        selectedIconTheme: IconThemeData(
            color: Colors.black
        ),
        unselectedItemColor: Colors.grey,
        unselectedIconTheme: IconThemeData(
          color: Colors.grey
        )
      ),

      scaffoldBackgroundColor: Color(0xFFeeeeeee),
      fontFamily: 'Montserrat', //3
    );
  }

}
