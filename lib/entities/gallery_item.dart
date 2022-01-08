import 'package:flutter/material.dart';

import 'package:password_manager/utils/enums.dart';
import 'package:password_manager/utils/enum_extension.dart';

class GalleryItem {
  final String name;
  final String imgUrl;
  final RecordType? recordType;

  const GalleryItem({
    Key? key,
    required this.name,
    required this.imgUrl,
    this.recordType,
  });

  factory GalleryItem.fromJson(Map json) {
    return GalleryItem(
      name: json['name'],
      imgUrl: json['img_url'],
      recordType:
          RecordType.values.firstWhere((e) => e.value == json['record_type']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'img_url': imgUrl,
      'record_type': recordType?.value,
    };
  }
}
