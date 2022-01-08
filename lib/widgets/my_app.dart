import 'package:flutter/material.dart';
import 'package:password_manager/controllers/app_router.dart';
import 'package:provider/provider.dart';

import 'package:password_manager/controllers/app_data.dart';
import 'package:password_manager/controllers/auth_controller.dart';
import 'package:password_manager/screens/auth/login_page.dart';
import 'package:password_manager/screens/auth/signup_page.dart';
import 'package:password_manager/screens/home_page.dart';
import 'package:password_manager/themes/app_theme_data.dart';

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = AppThemeData().theme;

    return Consumer<AuthController>(builder: (
      BuildContext context,
      AuthController authController,
      _,
    ) {
      return MaterialApp(
        title: AppData.APPNAME,
        debugShowCheckedModeBanner: false,
        theme: themeData,
        initialRoute: AppRouter.LOGIN_PAGE,
        routes: {
          AppRouter.HOME_PAGE: (BuildContext context) => HomePage(),
          AppRouter.SIGNUP_PAGE: (BuildContext context) => SignUpPage(),
          AppRouter.LOGIN_PAGE: (BuildContext context) => LoginPage(),
        },
      );
    });
  }
}
