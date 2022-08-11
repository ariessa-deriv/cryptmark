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

const PrimaryColor = const Color(0xFFfafafa);
const PrimaryColorLight = const Color(0xFFffffff);
const PrimaryColorDark = const Color(0xFFc7c7c7);

const SecondaryColor = const Color(0xFFf5f5f5);
const SecondaryColorLight = const Color(0xFFffffff);
const SecondaryColorDark = const Color(0xFFc2c2c2);

const Background = const Color(0xFFfffdf7);
const TextColor = const Color(0xFFffffff);

class CustomTheme {
  static ThemeData get lightTheme {
    //1
    return ThemeData(
      //2
      primaryColor: PrimaryColor,
      scaffoldBackgroundColor: PrimaryColorLight,
      fontFamily: 'Montserrat', //3
    );
  }
}
