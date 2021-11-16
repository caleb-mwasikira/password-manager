import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:password_manager/entities/item.dart';
import 'package:uuid/uuid.dart';

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
    username: "Rose Poole",
    email: "rosepoole@gmail.com",
    password: "rosepoole",
    vault: [],
  );

  static List<Item> categories = [
    Item(name: "School", imgUrl: "assets/images/categories/backpack.png"),
    Item(name: "Entertainment", imgUrl: "assets/images/categories/console.png"),
    Item(name: "Wallet", imgUrl: "assets/images/categories/wallet.png"),
    Item(name: "Hospital", imgUrl: "assets/images/categories/medicine.png"),
  ];

  static Future<List<String>> fetchAssetImages(String assetDir) async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = jsonDecode(manifestContent);
    final List<String> imagePaths =
        manifestMap.keys.where((String key) => key.contains(assetDir)).toList();

    return imagePaths;
  }
}
