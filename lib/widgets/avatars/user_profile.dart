import 'package:flutter/material.dart';

import 'package:password_manager/models/user.dart';
import 'package:password_manager/themes/app_theme_data.dart';
import 'package:password_manager/widgets/avatars/user_avatar.dart';

class UserProfile extends StatefulWidget {
  final User? user;

  final bool isEditable;
  final bool isSelected;
  final Axis axis;
  final MainAxisAlignment mainAxisAlignment;

  UserProfile({
    Key? key,
    required this.user,
    this.isEditable = false,
    this.isSelected = false,
    this.axis = Axis.horizontal,
    this.mainAxisAlignment = MainAxisAlignment.spaceAround,
  }) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Color get color => widget.isSelected ? Colors.white : AppThemeData.textColor;

  List<Widget> get userProfileChildren => [
        UserAvatar(
          imgUrl: widget.user?.profilePic,
          radius: 30.0,
          isEditable: widget.isEditable,
        ),
        SizedBox(width: 20.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: widget.axis == Axis.horizontal
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.user?.username ?? "",
              style:
                  Theme.of(context).textTheme.headline2?.copyWith(color: color),
            ),
            Text(
              widget.user?.email ?? "",
              style:
                  Theme.of(context).textTheme.bodyText1?.copyWith(color: color),
            ),
          ],
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: widget.isSelected ? Colors.lightBlue : Colors.white,
        borderRadius: AppThemeData.borderRadiusSmall,
      ),
      child: widget.axis == Axis.horizontal
          ? IntrinsicHeight(
              child: Row(
                mainAxisAlignment: widget.mainAxisAlignment,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: userProfileChildren,
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: userProfileChildren,
            ),
    );
  }
}
