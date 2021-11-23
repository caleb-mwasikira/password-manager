import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:favicon/favicon.dart' as Fav;

import 'package:password_manager/widgets/avatars/auth_record_avatar.dart';
import 'package:password_manager/themes/app_theme_data.dart';
import 'package:password_manager/utils/string_extension.dart';
import 'package:password_manager/entities/auth_record.dart';

// ignore: must_be_immutable
class AuthRecordWidget extends StatefulWidget {
  final AuthRecord authRecord;
  final bool isSelected;

  AuthRecordWidget({
    Key? key,
    required this.authRecord,
    this.isSelected = false,
  }) : super(key: key);

  @override
  _AuthRecordWidgetState createState() => _AuthRecordWidgetState();
}

class _AuthRecordWidgetState extends State<AuthRecordWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    AuthRecordAvatar(
                      websiteUri: widget.authRecord.websiteUrl,
                      radius: 25.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Uri.parse(widget.authRecord.websiteUrl)
                              .host
                              .split('.')[0]
                              .capitalize(),
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
                Container(
                  width: 20.0,
                  height: 20.0,
                  child: IconButton(
                    hoverColor: Colors.transparent,
                    iconSize: AppThemeData.iconsSizeMedium,
                    padding: EdgeInsets.zero,
                    alignment: Alignment.topRight,
                    onPressed: () {
                      print('[AuthRecord] menu button was clicked');
                    },
                    icon: Icon(
                      LineIcons.horizontalEllipsis,
                      color: widget.isSelected
                          ? AppThemeData.whiteColor
                          : AppThemeData.textColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 55.0),
            child: TextFormField(
              enabled: false,
              initialValue: widget.authRecord.password,
              readOnly: true,
              obscureText: true,
              showCursor: false,
              style: widget.isSelected
                  ? Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: Colors.white)
                  : Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
