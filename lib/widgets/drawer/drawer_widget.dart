import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import 'package:password_manager/controllers/app_router.dart';
import 'package:password_manager/controllers/user_controller.dart';
import 'package:password_manager/entities/drawer_item.dart';
import 'package:password_manager/models/user.dart';
import 'package:password_manager/widgets/drawer/drawer_item_widget.dart';
import 'package:password_manager/widgets/avatars/user_profile.dart';

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
      icon: LineIcons.theaterMasks,
      name: "Developers",
      isDisabled: true,
      onTap: (context) {
        throw UnimplementedError(
            "Route DEVELOPERS has not yet been implemented");
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
        UserController authController =
            Provider.of<UserController>(context, listen: false);

        authController.logoutUser(context);
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
        builder: (BuildContext context, UserController userController, _) {
      User? currentUser = userController.currentlyLoggedInUser;

      return Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            DrawerHeader(
              child: UserProfile(
                user: currentUser,
                isEditable: true,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.65,
              child: ListView.builder(
                itemCount: drawerItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return DrawerItemWidget(
                    drawerItem: drawerItems[index],
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
