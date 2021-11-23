import 'package:flutter/material.dart';

import 'package:password_manager/entities/enums.dart';
import 'package:password_manager/themes/app_theme_data.dart';
import 'package:password_manager/widgets/avatars/auth_record_avatar.dart';
import 'package:password_manager/widgets/gallery/gallery_item.dart';

class CircularGalleryItem extends StatefulWidget implements GalleryItem {
  final String? name;
  final String? imgUrl;
  final RecordType? recordType;

  final double radius;
  final bool isSelected;

  const CircularGalleryItem({
    Key? key,
    required this.name,
    required this.imgUrl,
    this.recordType,
    this.radius = 40.0,
    this.isSelected = false,
  }) : super(key: key);

  @override
  _CircularGalleryItemState createState() => _CircularGalleryItemState();
}

class _CircularGalleryItemState extends State<CircularGalleryItem> {
  final Color selectedColor = AppThemeData.randomColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: widget.isSelected ? selectedColor : Colors.transparent,
              width: 2.0,
            ),
          ),
          child: AuthRecordAvatar(
            websiteUri: widget.imgUrl,
            radius: widget.radius,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            widget.name ?? "Unknown",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ],
    );
  }
}
