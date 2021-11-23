import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'package:password_manager/widgets/avatars/user_photo.dart';
import 'package:password_manager/themes/app_theme_data.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: Builder(builder: (context) {
        return IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          iconSize: AppThemeData.iconsSizeMedium,
          icon: Icon(
            LineIcons.verticalEllipsis,
            color: AppThemeData.textColor,
          ),
        );
      }),
      actions: <Widget>[
        Row(
          children: [
            IconButton(
              onPressed: () {
                print("view notifications button was pressed");
              },
              tooltip: "View notifications",
              iconSize: AppThemeData.iconsSizeMedium,
              icon: Icon(
                LineIcons.bellAlt,
                color: AppThemeData.textColor,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: UserPhoto(
                imgUrl: null,
              ),
            ),
          ],
        )
      ],
    );
  }
}
