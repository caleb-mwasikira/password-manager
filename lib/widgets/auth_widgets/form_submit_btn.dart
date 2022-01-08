import 'package:flutter/material.dart';

import 'package:password_manager/themes/app_theme_data.dart';

class FormSubmitBtn extends StatefulWidget {
  final String title;
  final GlobalKey<FormState> formKey;
  final Function onSubmit;

  final Color backgroundColor;
  final double width, height;
  final EdgeInsets margin;

  const FormSubmitBtn({
    Key? key,
    required this.onSubmit,
    required this.formKey,
    required this.title,
    this.backgroundColor = AppThemeData.textColor,
    this.width = 300.0,
    this.height = 45.0,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  @override
  _FormSubmitBtnState createState() => _FormSubmitBtnState();
}

class _FormSubmitBtnState extends State<FormSubmitBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: ElevatedButton(
        onPressed: () {
          // First we validate all [TextFormField] widgets.
          // If all fields are successfully validated then we execute the
          // form's [onSubmit] function.
          FormState? currentFormState = widget.formKey.currentState;

          if (currentFormState != null && currentFormState.validate()) {
            currentFormState.save();

            widget.onSubmit();
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            widget.backgroundColor,
          ),
          fixedSize: MaterialStateProperty.all<Size>(
            Size(widget.width, widget.height),
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
