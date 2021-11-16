import 'package:flutter/material.dart';

import 'package:password_manager/themes/app_theme_data.dart';

// ignore: must_be_immutable
class DrawerItemWidget extends StatefulWidget {
  final IconData iconData;
  final String name;
  final Function onTap;

  DrawerItemWidget({
    Key? key,
    required this.iconData,
    required this.name,
    required this.onTap,
  }) : super(key: key);

  @override
  _DrawerItemWidgetState createState() => _DrawerItemWidgetState();
}

class _DrawerItemWidgetState extends State<DrawerItemWidget> {
  bool onHover = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: InkWell(
        hoverColor: Colors.lightBlueAccent,
        focusColor: Colors.lightBlue,
        onTap: () {
          widget.onTap();
        },
        onHover: (value) {
          setState(() {
            onHover = value;
          });
        },
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(
                  widget.iconData,
                  size: AppThemeData.iconsSizeMedium,
                  color: onHover
                      ? AppThemeData.whiteColor
                      : AppThemeData.textColor,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  widget.name,
                  style: onHover
                      ? Theme.of(context)
                          .textTheme
                          .headline3
                          ?.copyWith(color: Colors.white)
                      : Theme.of(context).textTheme.headline3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
