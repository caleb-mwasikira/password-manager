import 'package:flutter/material.dart';

import 'package:password_manager/widgets/avatars/auth_record_avatar.dart';
import 'package:password_manager/utils/string_extension.dart';
import 'package:password_manager/models/auth_record.dart';

// ignore: must_be_immutable
class AuthRecordWidget extends StatefulWidget {
  final AuthRecord authRecord;
  final List<Widget>? suffixMenuIcons;

  final bool isSelected;
  final Color selectedColor;
  final double avatarRadius;
  final BoxShape? avatarShape;

  AuthRecordWidget({
    Key? key,
    required this.authRecord,
    this.suffixMenuIcons,
    this.isSelected = false,
    this.selectedColor = Colors.white,
    this.avatarRadius = 25.0,
    this.avatarShape = BoxShape.circle,
  }) : super(key: key);

  @override
  _AuthRecordWidgetState createState() => _AuthRecordWidgetState();
}

class _AuthRecordWidgetState extends State<AuthRecordWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AuthRecordAvatar(
                  key: ValueKey(widget.authRecord.websiteUrl),
                  websiteUri: widget.authRecord.websiteUrl,
                  radius: widget.avatarRadius,
                  shape: widget.avatarShape,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Uri.parse(widget.authRecord.websiteUrl)
                          .host
                          .split('.')[1]
                          .capitalize(), // from www.google.com we take Google
                      overflow: TextOverflow.ellipsis,
                      style: widget.isSelected
                          ? Theme.of(context)
                              .textTheme
                              .headline3
                              ?.copyWith(color: Colors.white)
                          : Theme.of(context).textTheme.headline3,
                    ),
                    Container(
                      width: 150.0,
                      child: Text(
                        widget.authRecord.email,
                        overflow: TextOverflow.ellipsis,
                        style: widget.isSelected
                            ? Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: Colors.white)
                            : Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          widget.suffixMenuIcons != null
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.suffixMenuIcons!,
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
