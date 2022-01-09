import 'package:flutter/material.dart';

import 'package:password_manager/themes/app_theme_data.dart';

class ConfirmationDialog extends StatefulWidget {
  final String title;
  final void Function() onAccept;

  const ConfirmationDialog({
    Key? key,
    required this.title,
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning_rounded,
                  size: AppThemeData.iconSizeLarge * 2,
                  color: Colors.redAccent,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0),
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
                        "This action cannot be undone",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    dialogBtn(
                      context: context,
                      title: "Yes",
                      onPressed: () {
                        widget.onAccept();
                        Navigator.of(context).pop();
                      },
                    ),
                    dialogBtn(
                      context: context,
                      title: "Cancel",
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),

          // Close Button
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 20.0,
              height: 20.0,
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: AppThemeData.borderRadiusLarge,
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                padding: EdgeInsets.zero,
                splashRadius: 20.0,
                iconSize: AppThemeData.iconSizeSmall,
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container dialogBtn({
    required BuildContext context,
    required String title,
    required void Function()? onPressed,
    Color? backgroundColor,
    Color? textColor,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            backgroundColor ?? Colors.white,
          ),
          fixedSize: MaterialStateProperty.all<Size>(
            Size(100.0, 40.0),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: AppThemeData.borderRadiusSmall,
            ),
          ),
        ),
        child: Text(
          title,
          style:
              Theme.of(context).textTheme.headline3?.copyWith(color: textColor),
        ),
      ),
    );
  }
}
