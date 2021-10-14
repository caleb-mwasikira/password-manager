import 'package:flutter/material.dart';


class CustomTextStyle {
  static TextStyle title({Color color = Colors.black}) {
    return TextStyle(
      color: color,
      fontSize: 24.0,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle subTitle({Color color = Colors.black}) {
    return TextStyle(
      color: color,
      fontSize: 16.0,
      fontWeight: FontWeight.w700,
    );
  }
}