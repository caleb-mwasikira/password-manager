import 'package:flutter/material.dart';

import 'package:password_manager/widgets/avatar_widget.dart';
import 'package:password_manager/themes/custom_icons.dart';
import 'package:password_manager/widgets/drawer_item_widget.dart';

import 'package:password_manager/models/app_data.dart';
import 'package:password_manager/models/drawer_item.dart';


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
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
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
                  DrawerItem drawerItem = drawerItems[index];

                  return DrawerItemWidget(
                    iconData: drawerItem.icon, 
                    name: drawerItem.name,
                    onTap: drawerItem.onTap,
                  );
              }),
            ),
            DrawerItemWidget(
              iconData: CustomIcons.logout, 
              name: "Logout",
              onTap: () {
                print("logout drawer item was clicked");
              },
            ),
          ],
        ),
      );
  }
}
