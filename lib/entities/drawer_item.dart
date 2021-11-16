import 'package:flutter/material.dart';

class DrawerItem {
  final IconData icon;
  final String name;
  final Function onTap;

  DrawerItem({required this.icon, required this.name, required this.onTap});
}
