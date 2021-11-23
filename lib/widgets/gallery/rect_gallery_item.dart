import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import 'package:password_manager/entities/enums.dart';
import 'package:password_manager/widgets/avatars/auth_record_avatar.dart';
import 'package:password_manager/widgets/avatars/file_record_avatar.dart';
import 'package:password_manager/widgets/gallery/gallery_item.dart';
import 'package:password_manager/themes/app_theme_data.dart';
import 'package:password_manager/utils/enum_extension.dart';

class RectGalleryItem extends StatefulWidget implements GalleryItem {
  final String? name;
  final String? imgUrl;
  final RecordType? recordType;

  final bool isSelected;
  final double width, height;

  const RectGalleryItem({
    Key? key,
    required this.name,
    required this.imgUrl,
    this.recordType,
    this.isSelected = false,
    this.width = 200.0,
    this.height = 150.0,
  }) : super(key: key);

  @override
  _RectGalleryItemState createState() => _RectGalleryItemState();
}

class _RectGalleryItemState extends State<RectGalleryItem> {
  final Color selectedColor = AppThemeData.randomColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Card(
        elevation: widget.isSelected ? 5.0 : 1.0,
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        shadowColor:
            widget.isSelected ? selectedColor : AppThemeData.shadowColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: widget.width,
              height: widget.height - 50,
              child: widget.recordType == RecordType.AUTH
                  ? Center(
                      child: AuthRecordAvatar(
                        websiteUri: widget.imgUrl,
                        radius: 40.0,
                      ),
                    )
                  : FileRecordAvatar(
                      fileType: FileType.values.firstWhereOrNull(
                        (e) => e.list.contains(widget.name?.split('.').last),
                      ),
                      isSelected: widget.isSelected,
                      selectedColor: selectedColor,
                      iconSize: 40.0,
                    ),
            ),
            Divider(),
            Container(
              width: widget.width,
              child: Center(
                child: Text(
                  widget.name ?? "Unknown",
                  style: widget.isSelected
                      ? Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: selectedColor)
                      : Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
