import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import 'package:password_manager/controllers/app_router.dart';
import 'package:password_manager/controllers/auth_controller.dart';
import 'package:password_manager/entities/drawer_item.dart';
import 'package:password_manager/models/user.dart';
import 'package:password_manager/widgets/avatars/user_photo.dart';
import 'package:password_manager/widgets/drawer/drawer_item_widget.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  List<DrawerItem> drawerItems = [
    DrawerItem(
      icon: LineIcons.home,
      name: "Home",
      onTap: (context) {
        Navigator.pushNamed(context, AppRouter.HOME_PAGE);
      },
    ),
    DrawerItem(
      icon: LineIcons.userFriends,
      name: "Switch Accounts",
      isDisabled: true,
      onTap: (context) {
        throw UnimplementedError(
            "Event SWITCH_ACCOUNTS has not yet been implemented");
      },
    ),
    DrawerItem(
      icon: LineIcons.alternateCloudUpload,
      name: "Sync Accounts",
      isDisabled: true,
      onTap: (context) {
        throw UnimplementedError(
            "Event SYNC_ACCOUNTS has not yet been implemented");
      },
    ),
    DrawerItem(
      icon: LineIcons.cog,
      name: "Settings",
      isDisabled: true,
      onTap: (context) {
        throw UnimplementedError("Route SETTINGS has not yet been implemented");
      },
    ),
    DrawerItem(
      icon: LineIcons.alternateSignOut,
      name: "Logout",
      onTap: (context) {
        AuthController authController =
            Provider.of<AuthController>(context, listen: false);

        authController.logoutUser(context);
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
        builder: (BuildContext context, AuthController authController, _) {
      User? currentUser = authController.currentlyLoggedInUser;

      return Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            DrawerHeader(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  UserPhoto(
                    imgUrl: currentUser?.profilePic,
                    radius: 40.0,
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          currentUser?.username ?? "",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Text(
                          currentUser?.email ?? "",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
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
                  return DrawerItemWidget(
                    drawerItem: drawerItems[index],
                    marginVertical:
                        index == drawerItems.length - 1 ? 40.0 : 20.0,
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
