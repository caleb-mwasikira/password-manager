import 'package:flutter/material.dart';


// ignore: must_be_immutable
class AvatarWidget extends StatelessWidget {
  final String imgURL;
  double radius;

  AvatarWidget({ 
    Key? key, required this.imgURL, this.radius = 20.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: radius,
            foregroundImage: AssetImage(
              imgURL
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 24.0,
                height: 24.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radius)
                ),
                child: Center(
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      print("Edit avatar button was clicked");
                    },
                    tooltip: "Edit Profile Pic",
                    icon: Icon(
                        Icons.edit,
                        color: Colors.blueAccent,
                        size: 16.0,
                      ),
                  ),
                ),
              ),
            ),
          ),
      ],),
    );
  }
}