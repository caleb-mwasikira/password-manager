import 'dart:math';

import 'package:flutter/material.dart';

class AppThemeData {
  static double borderRadiusSize = 5.0;
  static BorderRadius borderRadius = BorderRadius.circular(borderRadiusSize);
  static BorderRadius borderRadiusMedium =
      BorderRadius.circular(borderRadiusSize * 2);
  static BorderRadius borderRadiusLarge =
      BorderRadius.circular(borderRadiusSize * 10);

  static const double iconSizeLarge = 35.0;
  static const double iconsSizeMedium = 20.0;
  static const double iconsSizeSmall = 15.0;

  static const Color primaryColor = Color(0XFF15ACA2);
  static const Color primaryColorDark = Color(0XFF048C7F);
  static const Color textColor = Color(0XFF324047);
  static const Color whiteColor = Color(0XFFFFFFFF);
  static const Color shadowColor = Color(0XFFF6F6F6);
  static const Color secondaryScaffoldBackgroundColor = Color(0XFFF8F7FC);

  static List<Color> colors = [
    Colors.lightBlueAccent,
    Colors.redAccent,
    Colors.pinkAccent,
    Colors.purpleAccent,
    Colors.orangeAccent
  ];

  static Color get randomColor {
    final _random = new Random();
    Color _randomColor = colors[_random.nextInt(colors.length)];
    return _randomColor;
  }

  ThemeData get theme {
    return ThemeData(
      fontFamily: "Roboto_Mono",
      primaryColor: primaryColor,
      primaryColorDark: primaryColorDark,
      shadowColor: Colors.grey,
      scaffoldBackgroundColor: whiteColor,
      textTheme: TextTheme(
        headline1: TextStyle(
          color: textColor,
          fontSize: 24.0,
          fontFamily: "Roboto_Mono",
          fontWeight: FontWeight.w400,
        ),
        headline2: TextStyle(
          color: textColor,
          fontSize: 18.0,
          fontFamily: "Roboto_Mono",
          fontWeight: FontWeight.w400,
        ),
        headline3: TextStyle(
          color: textColor,
          fontSize: 14.0,
          fontFamily: "Roboto_Mono",
        ),
        bodyText1: TextStyle(
          color: textColor,
          fontSize: 13.0,
          fontFamily: "Roboto_Mono",
          fontWeight: FontWeight.w400,
        ),
        bodyText2: TextStyle(
          color: textColor,
          fontSize: 12.0,
          fontFamily: "Roboto_Mono",
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
