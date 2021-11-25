import 'package:flutter/material.dart';

import 'package:password_manager/data/app_data.dart';
import 'package:password_manager/entities/drawer_item.dart';
import 'package:password_manager/entities/user.dart';
import 'package:password_manager/widgets/avatars/user_photo.dart';
import 'package:password_manager/widgets/drawer/drawer_item_widget.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({Key? key}) : super(key: key);

  void exitDrawer(BuildContext context) => Navigator.pop(context);

  @override
  DrawerWidget createState() => DrawerWidget();
}

class DrawerWidget extends State<CustomDrawer> {
  final List<DrawerItem> drawerItems = AppData.drawerItems;
  final User currentUser = AppData.currentUser;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                UserPhoto(
                  imgUrl: currentUser.profilePic,
                  radius: 40.0,
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(currentUser.username,
                          style: Theme.of(context).textTheme.headline1),
                      Text(currentUser.email,
                          style: Theme.of(context).textTheme.bodyText1),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.65,
            child: ListView.builder(
              itemCount: drawerItems.length,
              itemBuilder: (BuildContext context, int index) {
                DrawerItem drawerItem = drawerItems[index];

                return Container(
                  margin: EdgeInsets.only(
                      top: index == drawerItems.length - 1 ? 40.0 : 0.0),
                  child: DrawerItemWidget(
                    iconData: drawerItem.icon,
                    name: drawerItem.name,
                    onTap: drawerItem.onTap,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
