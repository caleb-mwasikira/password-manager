import 'package:flutter/material.dart';

import 'package:password_manager/themes/app_theme_data.dart';

class ProviderAuthBtn extends StatefulWidget {
  final String title;
  final IconData icon;
  final void Function() onPressed;
  final Color? color;
  final double width;

  const ProviderAuthBtn({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPressed,
    this.color,
    this.width = 250.0,
  }) : super(key: key);

  @override
  _ProviderAuthBtnState createState() => _ProviderAuthBtnState();
}

class _ProviderAuthBtnState extends State<ProviderAuthBtn> {
  bool onHover = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          Colors.white,
        ),
        fixedSize: MaterialStateProperty.all<Size>(
          Size(widget.width, 45.0),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: AppThemeData.borderRadiusSmall,
          ),
        ),
      ),
      child: Container(
        width: widget.width,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                widget.icon,
                size: AppThemeData.iconSizeMedium,
                color: onHover ? AppThemeData.whiteColor : widget.color,
              ),
              SizedBox(width: 20.0),
              Text(
                widget.title,
                style: onHover
                    ? Theme.of(context)
                        .textTheme
                        .headline3
                        ?.copyWith(color: Colors.white)
                    : Theme.of(context).textTheme.headline3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
