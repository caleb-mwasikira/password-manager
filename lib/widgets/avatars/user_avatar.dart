import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'package:password_manager/widgets/action_button.dart';
import 'package:password_manager/widgets/avatars/edit_user_avatar.dart';
import 'package:password_manager/themes/app_theme_data.dart';

// ignore: must_be_immutable
class UserAvatar extends StatefulWidget {
  String? imgUrl;
  final double radius;
  final bool isEditable;
  final BoxShape shape;
  final Color foregroundColor;

  UserAvatar({
    Key? key,
    required this.imgUrl,
    this.radius = 20.0,
    this.isEditable = false,
    this.shape = BoxShape.circle,
    this.foregroundColor = AppThemeData.textColor,
  }) : super(key: key);

  @override
  _UserAvatarState createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          widget.imgUrl != null
              ? widget.shape == BoxShape.circle
                  ? CircleAvatar(
                      radius: widget.radius,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage(widget.imgUrl!),
                    )
                  : Container(
                      width: widget.radius,
                      height: widget.radius,
                      child: ClipRRect(
                        clipBehavior: Clip.hardEdge,
                        borderRadius: AppThemeData.borderRadiusSmall,
                        child: Image.asset(
                          widget.imgUrl!,
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
              : Icon(
                  LineIcons.user,
                  color: widget.foregroundColor,
                  size: widget.radius * 2,
                ),
          widget.isEditable
              ? ActionButton(
                  iconData: Icons.edit,
                  onPressed: () async {
                    await editUserAvatar(context);
                  },
                )
              : SizedBox.shrink()
        ],
      ),
    );
  }

  Future<dynamic> editUserAvatar(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          elevation: 0.0,
          content: EditUserAvatar(),
        );
      },
    );
  }
}
