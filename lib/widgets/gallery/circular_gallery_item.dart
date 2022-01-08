import 'package:flutter/material.dart';

import 'package:password_manager/utils/enums.dart';
import 'package:password_manager/themes/app_theme_data.dart';

class CircularGalleryItem extends StatefulWidget {
  final String name;
  final String imgUrl;
  final RecordType? recordType;

  final double radius;
  final bool isSelected, isAssetImage;

  const CircularGalleryItem({
    Key? key,
    required this.name,
    required this.imgUrl,
    this.recordType,
    this.radius = 40.0,
    this.isSelected = false,
    this.isAssetImage = false,
  }) : super(key: key);

  @override
  _CircularGalleryItemState createState() => _CircularGalleryItemState();
}

class _CircularGalleryItemState extends State<CircularGalleryItem> {
  final Color selectedColor = AppThemeData.randomColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
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
              child: widget.isAssetImage
                  ? ClipRRect(
                      borderRadius: AppThemeData.borderRadiusLarge,
                      child: Image.asset(
                        widget.imgUrl,
                        fit: BoxFit.contain,
                        width: widget.radius,
                        height: widget.radius,
                      ),
                    )
                  : Card(
                      margin: EdgeInsets.symmetric(horizontal: 15.0),
                      elevation: 4.0,
                      shape: CircleBorder(),
                      clipBehavior: Clip.hardEdge,
                      child: Container(
                        width: widget.radius,
                        height: widget.radius,
                        padding: EdgeInsets.all(4.0),
                        child: Image.network(
                          widget.imgUrl,
                          fit: BoxFit.contain,
                        ),
                      ),
                    )),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              widget.name,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: widget.isSelected
                      ? selectedColor
                      : AppThemeData.textColor),
            ),
          ),
        ],
      ),
    );
  }
}
