import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:password_manager/widgets/my_app.dart';
import 'package:password_manager/controllers/vault_records_controller.dart';
import 'package:password_manager/controllers/user_controller.dart';
import 'package:password_manager/controllers/hive_boxes.dart';
import 'package:password_manager/controllers/app_data.dart';
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
