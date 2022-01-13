import 'package:flutter/material.dart';

import 'package:password_manager/themes/app_theme_data.dart';
import 'package:password_manager/widgets/common_widgets.dart';

class ConfirmationDialog extends StatefulWidget {
  final String title;
  final String? subTitle;
  final Icon? icon;
  final void Function() onAccept;

  const ConfirmationDialog({
    Key? key,
    required this.title,
    this.subTitle,
    this.icon,
    required this.onAccept,
  }) : super(key: key);

  @override
  State<ConfirmationDialog> createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      height: 250.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppThemeData.borderRadiusSmall,
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // [ConfimationDialog] icon
                widget.icon ?? SizedBox.shrink(),

                // [ConfimationDialog] title and subTitle
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          widget.title,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
                      Text(
                        widget.subTitle ?? "This action cannot be undone",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),

                // [ConfirmationDialog] accept and decline buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customButton(
                      context,
                      title: "Cancel",
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    customButton(
                      context,
                      title: "Confirm",
                      onPressed: widget.onAccept,
                      backgroundColor: Colors.blueAccent,
                      textColor: Colors.white,
                    ),
                  ],
                )
              ],
            ),
          ),
          closeButton(context),
        ],
      ),
    );
  }
}
