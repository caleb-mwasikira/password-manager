import 'package:flutter/material.dart';
import 'package:password_manager/themes/app_theme_data.dart';

// ignore: must_be_immutable
class ActionButton extends StatelessWidget {
  final IconData iconData;
  final double iconSize;
  final String? tooltip;

  final double radius;
  final Color color;
  final Color backgroundColor;
  late bool hasShadow;
  final EdgeInsets margin;
  final BoxShape shape;

  final void Function()? onPressed;

  ActionButton({
    Key? key,
    required this.iconData,
    this.iconSize = AppThemeData.iconsSizeSmall,
    this.tooltip,
    this.radius = 20.0,
    this.color = AppThemeData.primaryColor,
    this.backgroundColor = Colors.white,
    this.margin = EdgeInsets.zero,
    this.shape = BoxShape.circle,
    required this.onPressed,
  }) : super(key: key) {
    this.hasShadow = this.backgroundColor == Colors.transparent ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius,
      height: radius,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: shape,
        boxShadow: hasShadow
            ? [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(0, 3), // changes position of shadow
                )
              ]
            : [],
      ),
      child: Center(
        child: IconButton(
          icon: Icon(iconData),
          iconSize: iconSize,
          tooltip: tooltip,
          padding: EdgeInsets.zero,
          color: color,
          splashRadius: 20.0,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
