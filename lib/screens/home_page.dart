import 'package:flutter/material.dart';

import 'package:password_manager/widgets/drawer_widget.dart';
import 'package:password_manager/widgets/avatar_widget.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return InkWell(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Icon(
              Icons.menu_rounded,
              size: 20.0,
              color: Colors.white,
            ),
          );
        }),
        title: Tooltip(
          message: "Keeping your passwords secret",
          child: Container(
            width: 100.0,
            height: 100.0,
            child: Image.asset("assets/logos/design_1/Vault-logos_white.png"),
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              print("New password button was pressed");
            }, 
            tooltip: "New password",
            icon: Icon(Icons.add_box_outlined),
          ),
          AvatarWidget(imgURL: "assets/images/users/ed-pylypenko-7zcbtbI4E2o-unsplash.jpg")
        ],
      ),
      drawer: DrawerWidget(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
