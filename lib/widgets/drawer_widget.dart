import 'package:flutter/material.dart';
import 'package:password_manager/themes/custom_text_style.dart';

import 'package:password_manager/widgets/avatar_widget.dart';
import 'package:password_manager/themes/custom_icons.dart';
import 'package:password_manager/widgets/drawer_item.dart';

import 'package:password_manager/models/app_data.dart';
import 'package:password_manager/models/drawer_item_model.dart';


class DrawerWidget extends StatefulWidget {
  DrawerWidget({ Key? key }) : super(key: key);

  void exitDrawer(BuildContext context) => Navigator.pop(context);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  AvatarWidget(
                    imgURL: "assets/images/users/ed-pylypenko-7zcbtbI4E2o-unsplash.jpg",
                    radius: 40.0,
                    ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "Rose Poole",
                          style: CustomTextStyle.subTitle(),
                        ),
                        Text(
                          "rosepoole@gmail.com",
                        ),
                      ],
                    ),
                  )
                ],
              )
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.65,
              child: ListView.builder(
                itemCount: drawerItems.length,
                itemBuilder: (BuildContext context, int index) {
                  DrawerItemModel drawerItem = drawerItems[index];

                  return DrawerItem(
                    iconData: drawerItem.icon, 
                    name: drawerItem.name,
                    onTap: drawerItem.onTap,
                  );
              }),
            ),
            DrawerItem(
              iconData: CustomIcons.logout, 
              name: "Logout",
              onTap: () {
                print("Logout drawer-item was clicked");
              },
            ),
          ],
        ),
      );
  }
}
