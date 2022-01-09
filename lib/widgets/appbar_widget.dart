import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import 'package:password_manager/controllers/user_controller.dart';
import 'package:password_manager/widgets/avatars/user_avatar.dart';
import 'package:password_manager/themes/app_theme_data.dart';

AppBar appBarWidget() {
  return AppBar(
    backgroundColor: Colors.white,
    leading: Builder(builder: (context) {
      return IconButton(
        icon: Icon(
          LineIcons.verticalEllipsis,
          color: AppThemeData.textColor,
        ),
        iconSize: AppThemeData.iconSizeMedium,
        splashRadius: 20.0,
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      );
    }),
    actions: <Widget>[
      Consumer<UserController>(
          builder: (BuildContext context, UserController userController, _) {
        String? userProfile = userController.currentlyLoggedInUser?.profilePic;

        return Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: UserAvatar(
                imgUrl: userProfile,
                isEditable: true,
              ),
            ),
          ],
        );
      })
    ],
  );
}
