import 'package:flutter/material.dart';
import 'package:desktop_window/desktop_window.dart';

import 'package:password_manager/screens/home_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DesktopWindow.setMaxWindowSize(Size(800, 800));

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Key Vault',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Noto_Sans",
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Password Manager'),
    );
  }
}
