import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:password_manager/themes/app_theme_data.dart';

// ignore: must_be_immutable
class VaultAccountAvatar extends StatelessWidget {
  final double radius;
  final bool hasShadow;
  final String? imgUrl;

  VaultAccountAvatar({
    Key? key,
    this.radius = 25.0,
    this.hasShadow = true,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      padding: EdgeInsets.all(5.0),
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          hasShadow
              ? BoxShadow(
                  color: AppThemeData.shadowColor,
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(0, 3), // changes position of shadow
                )
              : BoxShadow()
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200.0),
        child: FittedBox(
            fit: BoxFit.fill,
            child: displayAccountAvatar(
              imgUrl: imgUrl,
            )),
      ),
    );
  }
}

Widget? displayAccountAvatar({String? imgUrl}) {
  if (imgUrl != null) {
    bool isValidUrl = Uri.parse(imgUrl).isAbsolute;

    if (isValidUrl) {
      return CachedNetworkImage(
        imageUrl: imgUrl,
        placeholder: (BuildContext context, String url) {
          return Container(
            width: 20.0,
            height: 20.0,
            child: CircularProgressIndicator(strokeWidth: 2.0),
          );
        },
        errorWidget: (context, url, error) => new Icon(Icons.error),
      );
    }
  }

  return Image.asset(imgUrl ?? "assets/images/icons/no_data_found.png");
}
