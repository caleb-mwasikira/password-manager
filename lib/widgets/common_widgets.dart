import 'package:flutter/material.dart';

import 'package:password_manager/themes/app_theme_data.dart';

SnackBar snackbarWidget({
  required BuildContext context,
  required String title,
  Color? backgroundColor,
  String? actionLabel,
  Function()? actionOnPressed,
}) {
  return SnackBar(
    backgroundColor: Colors.lightBlue,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: AppThemeData.borderRadiusSmall,
    ),
    width: 400.0,
    content: Container(
      height: 20.0,
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline3
              ?.copyWith(color: Colors.white),
        ),
      ),
    ),
    action: actionLabel != null && actionOnPressed != null
        ? SnackBarAction(
            label: actionLabel,
            textColor: Colors.white,
            onPressed: actionOnPressed,
          )
        : null,
  );
}

Widget closeButton(BuildContext context) {
  return Align(
    alignment: Alignment.topRight,
    child: Container(
      width: 20.0,
      height: 20.0,
      margin: EdgeInsets.all(10.0),
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
  );
}
