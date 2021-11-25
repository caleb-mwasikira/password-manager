import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:password_manager/entities/auth_record.dart';
import 'package:password_manager/entities/record.dart';
import 'package:uuid/uuid.dart';

import 'package:password_manager/widgets/gallery/gallery_item.dart';
import 'package:password_manager/entities/drawer_item.dart';
import 'package:password_manager/entities/user.dart';

class AppData {
  static String appName = "Password Manager";

  static List<DrawerItem> drawerItems = [
    DrawerItem(icon: LineIcons.home, name: "Home", onTap: () {}),
    DrawerItem(icon: LineIcons.lock, name: "Master Password", onTap: () {}),
    DrawerItem(
        icon: LineIcons.userFriends, name: "Switch Accounts", onTap: () {}),
    DrawerItem(icon: LineIcons.alternateSignIn, name: "Login", onTap: () {}),
    DrawerItem(
        icon: LineIcons.alternateCloudUpload,
        name: "Sync Accounts",
        onTap: () {}),
    DrawerItem(icon: LineIcons.theaterMasks, name: "Developers", onTap: () {}),
    DrawerItem(icon: LineIcons.cog, name: "Settings", onTap: () {}),
    DrawerItem(icon: LineIcons.alternateSignOut, name: "Logout", onTap: () {}),
  ];

  static User currentUser = User(
    id: Uuid().v1(),
    username: "Anon",
    email: "anonymous@wesbite.com",
    password: "anon",
    vault: [],
  );

  static List<GalleryItem> categories = [
    GalleryItem(
        name: "School", imgUrl: "assets/images/categories/backpack.png"),
    GalleryItem(
        name: "Entertainment", imgUrl: "assets/images/categories/console.png"),
    GalleryItem(
        name: "Wallet", imgUrl: "assets/images/categories/piggy_bank.png"),
  ];

  static Future<List<String>> fetchAssetImages({
    required String assetDir,
  }) async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = jsonDecode(manifestContent);
    final List<String> imagePaths =
        manifestMap.keys.where((String key) => key.contains(assetDir)).toList();

    return imagePaths;
  }

  static Future<List> fetchAssetData({
    required String dataDir,
    int? limit,
  }) async {
    final dataContent = await rootBundle.loadString(dataDir);
    final List data = jsonDecode(dataContent);

    data.shuffle();
    return limit != null ? data.take(limit).toList() : data;
  }
}
