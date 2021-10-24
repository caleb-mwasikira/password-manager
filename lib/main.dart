import 'package:flutter/material.dart';
import 'package:desktop_window/desktop_window.dart';

import 'package:password_manager/screens/home_page.dart';
import 'package:password_manager/themes/custom_colors.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DesktopWindow.setMinWindowSize(Size(800, 700));

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Key Vault',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Open_Sans",
        primaryColor: CustomColors.primaryLight,
        scaffoldBackgroundColor: CustomColors.backgroundColorWhite,
      ),
      home: HomePage(title: 'Password Manager'),
    );
  }
}
