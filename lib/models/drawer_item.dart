import 'package:flutter/material.dart';


class DrawerItem {
  final String name;
  final IconData icon;
  final Function onTap;

  DrawerItem({
    required this.name, required this.icon, 
    required this.onTap,
  });
}