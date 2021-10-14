import 'package:flutter/material.dart';


// ignore: must_be_immutable
class DrawerItem extends StatefulWidget {
  final IconData iconData;
  final String name;
  final Function onTap;

  DrawerItem({ 
    Key? key, 
    required this.iconData, required this.name,
    required this.onTap,
    }) : super(key: key);

  @override
  _DrawerItemState createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {
  bool onHover = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.symmetric(
        vertical: 10.0, horizontal: 20.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: InkWell(
        hoverColor: Colors.blueAccent,
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
                  size: 20.0,
                  color: onHover ? Colors.white : Colors.grey,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  widget.name,
                  style: TextStyle(
                    color: onHover ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}