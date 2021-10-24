import 'package:flutter/material.dart';

import 'package:password_manager/widgets/avatar_widget.dart';


class AppBarWidget extends StatefulWidget {
  const AppBarWidget({ Key? key }) : super(key: key);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.white,
        leading: Builder(builder: (context) {
          return InkWell(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Icon(
              Icons.menu_rounded,
              size: 20.0,
              color: Colors.grey,
            ),
          );
        }),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              print("New password button was pressed");
            }, 
            tooltip: "New password",
            icon: Icon(
              Icons.add,
              color: Colors.grey,
            ),
          ),
          AvatarWidget(imgURL: "assets/images/users/ed-pylypenko-7zcbtbI4E2o-unsplash.jpg")
        ],
      );
  }
}