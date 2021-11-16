import 'package:flutter/material.dart';

import 'package:password_manager/themes/app_theme_data.dart';
import 'package:password_manager/widgets/vault_account_avatar.dart';

class GalleryPhoto extends StatelessWidget {
  final String? name;
  final String? imgUrl;
  final BoxShape shape;
  final double radius;
  final bool isSelected;
  final Color color = AppThemeData.randomColor;

  GalleryPhoto({
    Key? key,
    required this.name,
    required this.imgUrl,
    this.shape = BoxShape.circle,
    this.radius = 40.0,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? color : Colors.transparent,
                width: 2.0,
              ),
            ),
            child: VaultAccountAvatar(
              imgUrl: imgUrl,
              radius: radius,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              name ?? "",
              style: TextStyle(
                fontSize: 13.0,
                color: isSelected ? color : AppThemeData.textColor,
                fontFamily: "Open_Sans",
              ),
            ),
          )
        ],
      ),
    );
  }
}
