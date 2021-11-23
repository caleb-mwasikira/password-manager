import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:clipboard/clipboard.dart';
import 'package:line_icons/line_icons.dart';
import 'package:regexpattern/regexpattern.dart';

import 'package:password_manager/themes/app_theme_data.dart';

class FormFieldWidget extends StatefulWidget {
  final String initialValue;
  final bool obscureText;
  final bool readOnly;
  final TextInputType textInputType;
  final String name;
  final String? labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final double width;

  FormFieldWidget({
    Key? key,
    this.initialValue = "",
    this.obscureText = false,
    this.readOnly = false,
    this.textInputType = TextInputType.text,
    required this.name,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.width = 300.0,
  }) : super(key: key);

  @override
  _FormFieldWidgetState createState() =>
      _FormFieldWidgetState(isTextHidden: obscureText, readOnly: readOnly);
}

class _FormFieldWidgetState extends State<FormFieldWidget> {
  bool readOnly;
  bool isTextHidden;
  String? errorMessage;

  _FormFieldWidgetState({required this.isTextHidden, required this.readOnly});

  String? _validateInputType({
    required String value,
    required TextInputType textInputType,
  }) {
    if (textInputType == TextInputType.emailAddress) {
      return !value.isEmail() ? 'input must be a valid email' : null;
    } else if (textInputType == TextInputType.url) {
      return !value.isUrl() ? 'input must be a valid url' : null;
    } else {
      return !value.isPasswordNormal1()
          ? 'please enter a strong password'
          : null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: AppThemeData.borderRadiusLarge,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: widget.width - 20,
                  child: TextFormField(
                    initialValue: widget.initialValue,
                    validator: (value) {
                      String? _errorMessage = "";

                      if (value == null || value.isEmpty) {
                        _errorMessage = '${widget.name} cannot be empty';
                      } else {
                        _errorMessage = _validateInputType(
                            value: value, textInputType: widget.textInputType);
                      }

                      setState(() {
                        errorMessage = _errorMessage ?? '';
                      });

                      return null;
                    },
                    obscureText: isTextHidden,
                    readOnly: readOnly,
                    style: Theme.of(context).textTheme.bodyText1,
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      prefixIcon: widget.prefixIcon != null
                          ? IconButton(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              hoverColor: Colors.transparent,
                              iconSize: AppThemeData.iconsSizeMedium,
                              tooltip: "Copy ${widget.name}",
                              onPressed: () {
                                FlutterClipboard.copy(widget.initialValue)
                                    .then((value) {
                                  print('copied ${widget.name} to clipboard');
                                });
                              },
                              icon: Icon(widget.prefixIcon),
                            )
                          : SizedBox.shrink(),
                      suffixIcon: widget.textInputType ==
                              TextInputType.visiblePassword
                          ? IconButton(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              hoverColor: Colors.transparent,
                              iconSize: AppThemeData.iconsSizeMedium,
                              color: AppThemeData.textColor,
                              tooltip: isTextHidden
                                  ? "View Password"
                                  : "Hide Password",
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
                      labelStyle: Theme.of(context).textTheme.bodyText1,
                      hintText: widget.hintText,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              errorMessage ?? "",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }
}
