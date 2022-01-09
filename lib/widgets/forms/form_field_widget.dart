import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:regexpattern/regexpattern.dart';

import 'package:password_manager/utils/enums.dart';
import 'package:password_manager/themes/app_theme_data.dart';
import 'package:password_manager/utils/utils.dart';

class FormFieldWidget extends StatefulWidget {
  final String initialText;
  final bool obscureText;
  final bool readOnly;
  final InputType textInputType;
  final String name;
  final String? labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final double width;
  final void Function(String?)? onSaved;

  FormFieldWidget({
    Key? key,
    this.initialText = "",
    this.obscureText = false,
    this.readOnly = false,
    this.textInputType = InputType.TEXT,
    required this.name,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.width = 280.0,
    required this.onSaved,
  }) : super(key: key);

  @override
  _FormFieldWidgetState createState() =>
      _FormFieldWidgetState(isTextHidden: obscureText, readOnly: readOnly);
}

class _FormFieldWidgetState extends State<FormFieldWidget> {
  bool readOnly;
  bool isTextHidden;

  late TextEditingController _textEditingController;

  _FormFieldWidgetState({
    required this.isTextHidden,
    required this.readOnly,
  });

  @override
  void initState() {
    _textEditingController =
        new TextEditingController(text: widget.initialText);

    super.initState();
  }

  String? _validateEmail(String value) =>
      value.toLowerCase().isEmail() ? null : "Input must be a valid email";

  String? _validatePassword(String value) =>
      value.isPasswordEasy() ? null : "Please enter a strong password";

  String? _validateURI(String value) =>
      value.toLowerCase().isUrl() ? null : "Input must be a valid URL";

  String? _validateText(String value, {double maxLength = double.infinity}) =>
      value.length <= maxLength
          ? null
          : "Input cannot exceed $maxLength characters";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: AppThemeData.borderRadiusSmall,
        ),
        margin: EdgeInsets.symmetric(vertical: 15.0),
        child: Container(
          width: widget.width - 20,
          child: TextFormField(
            controller: _textEditingController,
            obscureText: isTextHidden,
            readOnly: readOnly,
            textAlignVertical: TextAlignVertical.center,
            style: Theme.of(context).textTheme.bodyText1,
            validator: (String? value) {
              String? _errorMessage;

              if (value == null || value.isEmpty) {
                _errorMessage = "${widget.name} cannot be empty";
              } else {
                switch (widget.textInputType) {
                  case InputType.EMAIL:
                    _errorMessage = _validateEmail(value);
                    break;
                  case InputType.PASSWORD:
                    _errorMessage = _validatePassword(value);
                    break;
                  case InputType.URL:
                    _errorMessage = _validateURI(value);
                    break;
                  default:
                    _errorMessage = _validateText(value, maxLength: 20);
                }
              }

              return _errorMessage;
            },
            onSaved: widget.onSaved,
            decoration: InputDecoration(
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              prefixIcon: widget.prefixIcon != null
                  ? IconButton(
                      icon: Icon(widget.prefixIcon),
                      iconSize: AppThemeData.iconSizeMedium,
                      hoverColor: Colors.transparent,
                      tooltip: widget.textInputType == InputType.PASSWORD
                          ? "Generate Password?"
                          : null,
                      onPressed: () {
                        if (widget.textInputType == InputType.PASSWORD) {
                          setState(() {
                            _textEditingController.text = getRandomString(12);
                          });
                        }
                      },
                    )
                  : SizedBox.shrink(),
              suffixIcon: widget.textInputType == InputType.PASSWORD
                  ? IconButton(
                      icon: Icon(
                          isTextHidden ? LineIcons.eye : LineIcons.eyeSlash),
                      iconSize: AppThemeData.iconSizeMedium,
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      hoverColor: Colors.transparent,
                      tooltip: isTextHidden ? "View Password" : "Hide Password",
                      splashRadius: 20.0,
                      onPressed: () {
                        setState(() {
                          isTextHidden = !isTextHidden;
                        });
                      },
                    )
                  : SizedBox.shrink(),
              labelText: widget.labelText,
              labelStyle: Theme.of(context).textTheme.bodyText2,
              hintText: widget.hintText,
              errorStyle: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(height: 0, color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}
