import 'package:flutter/material.dart';


class DrawerItemModel {
  final String name;
  final IconData icon;
  final Function onTap;

  DrawerItemModel({
    required this.name, required this.icon, 
    required this.onTap,
  });
}