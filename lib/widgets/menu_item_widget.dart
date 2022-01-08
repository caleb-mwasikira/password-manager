import 'package:flutter/material.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:password_manager/entities/menu_item.dart';

import 'package:password_manager/themes/app_theme_data.dart';

// ignore: must_be_immutable
class MenuItemWidget extends StatefulWidget {
  final MenuItem menuItem;
  final CustomPopupMenuController popupMenuController;
  final void Function(MenuItem selectedMenuItem) onSelectMenuItem;

  final double width, height;
  final BorderRadius? borderRadius;

  MenuItemWidget({
    Key? key,
    required this.menuItem,
    required this.popupMenuController,
    required this.onSelectMenuItem,
    this.width = 100.0,
    this.height = 40.0,
    this.borderRadius,
  }) : super(key: key);

  @override
  _MenuItemWidgetState createState() => _MenuItemWidgetState();
}

class _MenuItemWidgetState extends State<MenuItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: EdgeInsets.all(2.0),
      margin: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: widget.borderRadius,
      ),
      child: InkWell(
        onTap: () {
          widget.popupMenuController.hideMenu();

          widget.onSelectMenuItem(widget.menuItem);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              widget.menuItem.icon,
              size: AppThemeData.iconsSizeMedium,
              color: Colors.white,
            ),
            widget.menuItem.title != null
                ? Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                    child: Text(
                      widget.menuItem.title!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: Colors.white),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
