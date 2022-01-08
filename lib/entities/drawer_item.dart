import 'package:flutter/material.dart';

class DrawerItem {
  final IconData icon;
  final String name;
  final bool isDisabled;
  final Function(BuildContext context) onTap;

  DrawerItem({
    required this.icon,
    required this.name,
    this.isDisabled = false,
    required this.onTap,
  });
}
