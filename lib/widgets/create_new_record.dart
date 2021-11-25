import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'package:password_manager/data/app_data.dart';
import 'package:password_manager/entities/enums.dart';
import 'package:password_manager/widgets/form_field_widget.dart';
import 'package:password_manager/widgets/gallery/gallery.dart';
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

  String get title {
    return widget.recordType == RecordType.AUTH ? "Auth Record" : "File Record";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400.0,
      height: 500.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10.0, bottom: 40.0, top: 10.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.recordType == RecordType.AUTH
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FormFieldWidget(
                            name: "Website Url",
                            labelText: "Website Url",
                            textInputType: TextInputType.url,
                            prefixIcon: LineIcons.cloud,
                          ),
                          FormFieldWidget(
                            name: "Email",
                            labelText: "Email",
                            textInputType: TextInputType.emailAddress,
                            prefixIcon: LineIcons.envelope,
                          ),
                          FormFieldWidget(
                            name: "Password",
                            labelText: "Password",
                            obscureText: true,
                            textInputType: TextInputType.visiblePassword,
                            prefixIcon: LineIcons.lock,
                          ),
                        ],
                      )
                    : Container(),
                Gallery(
                  galleryTitle: "Select Category",
                  items: AppData.categories,
                  isAssetImages: true,
                  width: 400.0,
                  margin:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                ),
                ElevatedButton(
                  onPressed: () {
                    // First we validate all [TextFormField] widgets.
                    // If all fields are successfully validated then we execute the
                    // form's [onComplete] function.
                    FormState? currentFormState = _formKey.currentState;

                    if (currentFormState != null &&
                        currentFormState.validate()) {
                      currentFormState.save();

                      widget.onComplete();
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        AppThemeData.textColor),
                    fixedSize: MaterialStateProperty.all<Size>(Size(300, 50.0)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: AppThemeData.borderRadiusLarge,
                      ),
                    ),
                  ),
                  child: Text(
                    "Create $title",
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        ?.copyWith(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
