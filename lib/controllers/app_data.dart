import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import 'package:password_manager/entities/gallery_item.dart';

class AppData {
  static const String APPNAME = "Password Manager";

  static Future<String> get _appDir async {
    var _documentsDir = await getApplicationDocumentsDirectory();

    var _appDir =
        await Directory(path.join(_documentsDir.path, ".password_manager"))
            .create(recursive: true);
    return _appDir.path;
  }

  static Future<String> get appStorageDir async {
    return path.join(await _appDir, ".storage");
  }

  static Future<String> get appIconsDir async {
    // Create app icons directory
    var _appIconsDir = await Directory(path.join(await _appDir, ".icons"))
        .create(recursive: true);

    return _appIconsDir.path;
  }

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
