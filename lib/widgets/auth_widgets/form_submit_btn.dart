import 'package:flutter/material.dart';

import 'package:password_manager/themes/app_theme_data.dart';

class FormSubmitBtn extends StatefulWidget {
  final Function onComplete;
  final GlobalKey<FormState> formKey;

  final String title;
  final Color backgroundColor;
  final double width;

  const FormSubmitBtn({
    Key? key,
    required this.onComplete,
    required this.formKey,
    required this.title,
    this.backgroundColor = AppThemeData.textColor,
    this.width = 300.0,
  }) : super(key: key);

  @override
  _FormSubmitBtnState createState() => _FormSubmitBtnState();
}

class _FormSubmitBtnState extends State<FormSubmitBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      child: ElevatedButton(
        onPressed: () {
          // First we validate all [TextFormField] widgets.
          // If all fields are successfully validated then we execute the
          // form's [onComplete] function.
          FormState? currentFormState = widget.formKey.currentState;

          if (currentFormState != null && currentFormState.validate()) {
            currentFormState.save();

            widget.onComplete();
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            widget.backgroundColor,
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
        child: Text(
          widget.title,
          style: Theme.of(context)
              .textTheme
              .headline3
              ?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
