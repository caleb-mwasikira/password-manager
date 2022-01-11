import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:password_manager/controllers/app_router.dart';
import 'package:password_manager/controllers/app_data.dart';
import 'package:password_manager/screens/auth/login_page.dart';
import 'package:password_manager/screens/auth/signup_page.dart';
import 'package:password_manager/screens/home_page.dart';
import 'package:password_manager/themes/app_theme_data.dart';
import 'package:password_manager/controllers/vault_records_controller.dart';
import 'package:password_manager/controllers/user_controller.dart';
import 'package:password_manager/controllers/hive_boxes.dart';
import 'package:password_manager/models/user.dart';
import 'package:password_manager/models/auth_record.dart';
import 'package:password_manager/models/file_record.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle(AppData.APPNAME);
    setWindowMinSize(Size(900, 700));
    setWindowMaxSize(Size(900, 700));
  }

  await Hive.initFlutter(await AppData.appStorageDir);
  Hive
    ..registerAdapter(AuthRecordAdapter())
    ..registerAdapter(FileRecordAdapter())
    ..registerAdapter(UserAdapter());

  await Hive.openBox<AuthRecord>(HiveBoxes.authRecords);
  await Hive.openBox<FileRecord>(HiveBoxes.fileRecords);
  await Hive.openBox<User>(HiveBoxes.users);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => VaultRecordsController(
            recordBoxes: [
              Hive.box<AuthRecord>(HiveBoxes.authRecords),
              Hive.box<FileRecord>(HiveBoxes.fileRecords)
            ],
          ),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              UserController(usersBox: Hive.box<User>(HiveBoxes.users)),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = AppThemeData().theme;

    return MaterialApp(
      title: AppData.APPNAME,
      debugShowCheckedModeBanner: false,
      theme: themeData,
      initialRoute: AppRouter.SIGNUP_PAGE,
      routes: {
        AppRouter.HOME_PAGE: (BuildContext context) => HomePage(),
        AppRouter.SIGNUP_PAGE: (BuildContext context) => SignUpPage(),
        AppRouter.LOGIN_PAGE: (BuildContext context) => LoginPage(),
      },
    );
  }
}
