import 'package:flutter/material.dart';

class Item {
  dynamic name;
  String? imgUrl;
  IconData? icon;

  Item({required this.name, this.imgUrl, this.icon});

  factory Item.fromJson(Map json) {
    return Item(
      name: json['name'],
      imgUrl: json['img_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "img_url": imgUrl,
    };
  }
}
