import 'package:flutter/material.dart';

import 'package:password_manager/themes/custom_icons.dart';
import 'package:password_manager/models/drawer_item.dart';


final List<DrawerItem> drawerItems = [
  DrawerItem(name: "Home", icon: CustomIcons.home, onTap: (){
    print("home drawer item was clicked");
  }),
  DrawerItem(name: "Switch Account", icon: Icons.switch_account_outlined, onTap: (){
    print("switch account drawer item was clicked");
  }),
  DrawerItem(name: "Sync Accounts", icon: CustomIcons.cloud_upload, onTap: (){
    print("sync accounts drawer item was clicked");
  }),
  DrawerItem(name: "Dark/Light Mode", icon: CustomIcons.moon_1, onTap: (){
    print("dark/light mode drawer item was clicked");
  }),
  DrawerItem(name: "Settings", icon: CustomIcons.cog, onTap: (){
    print("settings drawer item was clicked");
  }),
];