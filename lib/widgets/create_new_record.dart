import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'package:password_manager/data/app_data.dart';
import 'package:password_manager/entities/enums.dart';
import 'package:password_manager/widgets/form_field_widget.dart';
import 'package:password_manager/widgets/gallery.dart';
import 'package:password_manager/themes/app_theme_data.dart';

class CreateNewRecord extends StatefulWidget {
  final RecordType recordType;
  final Function onComplete;

  const CreateNewRecord({
    Key? key,
    required this.recordType,
    required this.onComplete,
  }) : super(key: key);

  @override
  _CreateNewRecordState createState() => _CreateNewRecordState();
}

class _CreateNewRecordState extends State<CreateNewRecord> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          widget.recordType == RecordType.AUTH
              ? Container(
                  child: Column(
                    children: [
                      FormFieldWidget(
                          labelText: "Website Url",
                          textInputType: TextInputType.url,
                          prefixIcon: LineIcons.cloud),
                      FormFieldWidget(
                          labelText: "Email",
                          textInputType: TextInputType.emailAddress,
                          prefixIcon: LineIcons.inbox),
                      FormFieldWidget(
                        obscureText: true,
                        labelText: "Password",
                        textInputType: TextInputType.visiblePassword,
                        prefixIcon: LineIcons.lock,
                      ),
                    ],
                  ),
                )
              : Container(),
          Gallery(
            title: "Select Category",
            name: "Category",
            items: AppData.categories
                .map((category) => category.toJson())
                .toList(),
          ),
          ElevatedButton(
            onPressed: () {
              // First we validate all [TextFormField] widgets.
              // If all fields are successfully validated then we execute the
              // form's [onComplete] function.
              FormState? currentFormState = _formKey.currentState;

              if (currentFormState != null && currentFormState.validate()) {
                currentFormState.save();

                widget.onComplete();
              }
            },
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(AppThemeData.textColor),
              fixedSize: MaterialStateProperty.all<Size>(Size(250, 40.0)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            child: Text(
              "Save Account",
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  ?.copyWith(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
