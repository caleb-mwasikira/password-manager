import 'package:flutter/material.dart';

import 'package:password_manager/entities/drawer_item.dart';
import 'package:password_manager/themes/app_theme_data.dart';

// ignore: must_be_immutable
class DrawerItemWidget extends StatefulWidget {
  final DrawerItem drawerItem;

  DrawerItemWidget({
    Key? key,
    required this.drawerItem,
  }) : super(key: key);

  @override
  _DrawerItemWidgetState createState() => _DrawerItemWidgetState();
}

class _DrawerItemWidgetState extends State<DrawerItemWidget> {
  bool onHover = false;
  bool get isDisabled => widget.drawerItem.isDisabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Tooltip(
        message: isDisabled ? "Not Yet Implemented" : "",
        child: InkWell(
          hoverColor:
              isDisabled ? AppThemeData.textColor : Colors.lightBlueAccent,
          focusColor: isDisabled ? AppThemeData.textColor : Colors.lightBlue,
          mouseCursor: isDisabled
              ? SystemMouseCursors.forbidden
              : SystemMouseCursors.click,
          onTap: () {
            if (!widget.drawerItem.isDisabled) {
              widget.drawerItem.onTap(context);
            } else {
              print(
                  "DrawerWidget ${widget.drawerItem.name} is currently disabled");
            }
          },
          onHover: (value) {
            setState(() {
              onHover = value;
            });
          },
          borderRadius: AppThemeData.borderRadiusLarge,
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Icon(
                    widget.drawerItem.icon,
                    size: AppThemeData.iconSizeMedium,
                    color: onHover
                        ? AppThemeData.whiteColor
                        : AppThemeData.textColor,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    widget.drawerItem.name,
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
      ),
    );
  }
}
