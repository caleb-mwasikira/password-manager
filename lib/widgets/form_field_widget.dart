import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:clipboard/clipboard.dart';
import 'package:line_icons/line_icons.dart';
import 'package:regexpattern/regexpattern.dart';

import 'package:password_manager/widgets/action_button.dart';
import 'package:password_manager/themes/app_theme_data.dart';

// ignore: must_be_immutable
class FormFieldWidget extends StatefulWidget {
  String initialValue;
  bool obscureText;
  bool readOnly;
  TextInputType textInputType;
  String labelText;
  IconData prefixIcon;

  FormFieldWidget({
    Key? key,
    this.initialValue = "",
    this.obscureText = false,
    this.readOnly = false,
    this.textInputType = TextInputType.text,
    required this.labelText,
    required this.prefixIcon,
  }) : super(key: key);

  @override
  _FormFieldWidgetState createState() =>
      _FormFieldWidgetState(isTextHidden: obscureText, readOnly: readOnly);
}

class _FormFieldWidgetState extends State<FormFieldWidget> {
  bool readOnly;
  bool isTextHidden;
  bool isValid = false;

  _FormFieldWidgetState({required this.isTextHidden, required this.readOnly});

  String? validateInputType({
    required String value,
    required TextInputType textInputType,
  }) {
    if (textInputType == TextInputType.emailAddress && !value.isEmail()) {
      return 'input must be a valid email';
    } else if (textInputType == TextInputType.url && !value.isUrl()) {
      return 'input must be a valid url';
    } else if (textInputType == TextInputType.visiblePassword &&
        !value.isPasswordNormal1()) {
      return 'please enter a strong password';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 300.0,
          margin: EdgeInsets.symmetric(vertical: 5.0),
          child: TextFormField(
            initialValue: widget.initialValue,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '${widget.labelText.toLowerCase()} cannot be empty';
              }

              String? message = validateInputType(
                  value: value, textInputType: widget.textInputType);

              bool _isValid = message == null ? true : false;
              setState(() {
                isValid = _isValid;
              });

              return message;
            },
            obscureText: isTextHidden,
            readOnly: readOnly,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: 15.0, letterSpacing: 2),
            decoration: InputDecoration(
                focusedBorder: outlineInputBorder(context: context, width: 4.0),
                enabledBorder: outlineInputBorder(context: context),
                prefixIcon: IconButton(
                    hoverColor: Colors.transparent,
                    iconSize: AppThemeData.iconsSizeMedium,
                    tooltip: "Copy ${widget.labelText}",
                    onPressed: () {
                      FlutterClipboard.copy(widget.initialValue).then((value) {
                        print('copied ${widget.labelText} to clipboard');
                      });
                    },
                    icon: Icon(widget.prefixIcon)),
                suffixIcon: widget.textInputType ==
                        TextInputType.visiblePassword
                    ? IconButton(
                        hoverColor: Colors.transparent,
                        iconSize: AppThemeData.iconsSizeMedium,
                        tooltip:
                            isTextHidden ? "View Password" : "Hide Password",
                        onPressed: () {
                          setState(() {
                            isTextHidden = !isTextHidden;
                          });
                        },
                        icon: Icon(isTextHidden
                            ? LineIcons.eye
                            : LineIcons.eyeSlashAlt),
                      )
                    : SizedBox.shrink(),
                labelText: widget.labelText,
                labelStyle: Theme.of(context).textTheme.bodyText1),
          ),
        ),
        isValid
            ? ActionButton(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                hasShadow: false,
                child: Icon(
                  LineIcons.checkCircle,
                  color: Colors.greenAccent,
                ),
              )
            : SizedBox(width: 25.0)
      ],
    );
  }

  UnderlineInputBorder outlineInputBorder({
    required BuildContext context,
    double width = 2.0,
  }) {
    return UnderlineInputBorder(
      borderSide:
          BorderSide(color: Theme.of(context).primaryColor, width: width),
      borderRadius: AppThemeData.borderRadius,
    );
  }
}
