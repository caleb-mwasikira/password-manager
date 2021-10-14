import 'package:flutter/material.dart';

import 'package:password_manager/themes/custom_icons.dart';
import 'package:password_manager/models/drawer_item_model.dart';


final List<DrawerItemModel> drawerItems = [
  DrawerItemModel(name: "Home", icon: CustomIcons.home, onTap: (){
    print("Home drawer-item was clicked");
  }),
  DrawerItemModel(name: "Switch Account", icon: Icons.switch_account_outlined, onTap: (){
    print("Switch Account drawer-item was clicked");
  }),
  DrawerItemModel(name: "Sync Accounts", icon: CustomIcons.cloud_upload, onTap: (){
    print("Sync Accounts drawer-item was clicked");
  }),
  DrawerItemModel(name: "Dark/Light Mode", icon: CustomIcons.moon_1, onTap: (){
    print("Dark/Light Mode drawer-item was clicked");
  }),
  DrawerItemModel(name: "Settings", icon: CustomIcons.cog, onTap: (){
    print("Settings drawer-item was clicked");
  }),
];