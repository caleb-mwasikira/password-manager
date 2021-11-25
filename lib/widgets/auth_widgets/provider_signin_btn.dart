import 'package:flutter/material.dart';

import 'package:password_manager/themes/app_theme_data.dart';

class ProviderSignInBtn extends StatefulWidget {
  final String providerTitle;
  final IconData providerIcon;
  final Function onBtnPressed;
  final Color? providerColor;
  final double width;

  const ProviderSignInBtn({
    Key? key,
    required this.providerTitle,
    required this.providerIcon,
    required this.onBtnPressed,
    this.providerColor,
    this.width = 300.0,
  }) : super(key: key);

  @override
  _ProviderSignInBtnState createState() => _ProviderSignInBtnState();
}

class _ProviderSignInBtnState extends State<ProviderSignInBtn> {
  bool onHover = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.onBtnPressed();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          Colors.white,
        ),
        fixedSize: MaterialStateProperty.all<Size>(
          Size(widget.width, 50.0),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: AppThemeData.borderRadiusLarge,
          ),
        ),
      ),
      child: Container(
        width: widget.width,
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(
                  widget.providerIcon,
                  size: AppThemeData.iconsSizeMedium,
                  color:
                      onHover ? AppThemeData.whiteColor : widget.providerColor,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  widget.providerTitle,
                  style: onHover
                      ? Theme.of(context)
                          .textTheme
                          .headline3
                          ?.copyWith(color: Colors.white)
                      : Theme.of(context).textTheme.headline3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
