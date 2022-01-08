import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:password_manager/controllers/auth_controller.dart';

import 'package:password_manager/widgets/avatars/user_photo.dart';
import 'package:password_manager/themes/app_theme_data.dart';
import 'package:provider/provider.dart';

AppBar appBarWidget() {
  return AppBar(
    backgroundColor: Colors.white,
    leading: Builder(builder: (context) {
      return IconButton(
        icon: Icon(
          LineIcons.verticalEllipsis,
          color: AppThemeData.textColor,
        ),
        iconSize: AppThemeData.iconsSizeMedium,
        splashRadius: 20.0,
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      );
    }),
    actions: <Widget>[
      Consumer<AuthController>(
          builder: (BuildContext context, AuthController authController, _) {
        String? userProfile = authController.currentlyLoggedInUser?.profilePic;

        return Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: UserPhoto(
                imgUrl: userProfile,
              ),
            ),
          ],
        );
      })
    ],
  );
}
