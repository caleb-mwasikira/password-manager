import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:password_manager/themes/app_theme_data.dart';

// ignore: must_be_immutable
class RecordDetail extends StatefulWidget {
  final String title;
  final String detail;
  bool canBeCopied;

  RecordDetail({
    Key? key,
    required this.title,
    required this.detail,
    this.canBeCopied = false,
  }) : super(key: key);

  @override
  _RecordDetailState createState() => _RecordDetailState();
}

class _RecordDetailState extends State<RecordDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      margin: EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.headline3,
          ),
          SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.detail,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              widget.canBeCopied
                  ? IconButton(
                      icon: Icon(LineIcons.clipboard),
                      iconSize: AppThemeData.iconsSizeMedium,
                      tooltip: "Copy ${widget.title.toLowerCase()}",
                      splashRadius: 20.0,
                      onPressed: () {
                        print(
                            "Copied ${widget.title.toLowerCase()} to clipboard");
                        FlutterClipboard.copy(widget.detail);
                      },
                    )
                  : SizedBox.shrink()
            ],
          )
        ],
      ),
    );
  }
}
