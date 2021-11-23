import 'package:flutter/material.dart';

import 'package:password_manager/entities/enums.dart';

class GalleryItem {
  final String? name;
  final String? imgUrl;
  final RecordType? recordType;
  final bool isSelected;

  const GalleryItem({
    Key? key,
    required this.name,
    required this.imgUrl,
    this.recordType,
    this.isSelected = false,
  });
}
