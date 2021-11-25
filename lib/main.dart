import 'dart:io';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';

import 'package:password_manager/screens/auth/signin_page.dart';
import 'package:password_manager/screens/auth/signup_page.dart';
import 'package:password_manager/screens/home_page.dart';
import 'package:password_manager/data/app_data.dart';
import 'package:password_manager/themes/app_theme_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle(AppData.appName);
    setWindowMinSize(Size(900, 700));
    setWindowMaxSize(Size(900, 700));
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = AppThemeData().theme;

    return MaterialApp(
      title: AppData.appName,
      debugShowCheckedModeBanner: false,
      theme: themeData,
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        '/signin': (BuildContext context) => SignInPage(),
        '/signup': (BuildContext context) => SignUpPage(),
      },
    );
  }
}
