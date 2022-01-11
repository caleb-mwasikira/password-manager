import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'package:password_manager/widgets/common_widgets.dart';
import 'package:password_manager/widgets/avatars/auth_record_avatar.dart';
import 'package:password_manager/controllers/vault_records_controller.dart';
import 'package:password_manager/controllers/app_data.dart';
import 'package:password_manager/models/auth_record.dart';
import 'package:password_manager/widgets/auth_widgets/form_submit_btn.dart';
import 'package:password_manager/widgets/forms/form_field_widget.dart';
import 'package:password_manager/utils/enums.dart';
import 'package:password_manager/widgets/gallery/gallery.dart';
import 'package:password_manager/entities/gallery_item.dart';
import 'package:password_manager/utils/enum_extension.dart';

class AuthRecordForm extends StatefulWidget {
  final String title = "Auth Record";
  final double width, height;

  AuthRecordForm({
    Key? key,
    this.width = 400.0,
    this.height = 500.0,
  }) : super(key: key);

  @override
  _AuthRecordFormState createState() => _AuthRecordFormState();
}

class _AuthRecordFormState extends State<AuthRecordForm> {
  final formKey = GlobalKey<FormState>();

  String? websiteUrl;
  String? email;
  String? password;
  GalleryItem? category;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            child: AuthRecordAvatar(
              websiteUri: websiteUrl,
              radius: 40.0,
            ),
          ),
          Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FormFieldWidget(
                      name: "Website Url",
                      hintText: "https://www.example.com",
                      textInputType: InputType.URL,
                      prefixIcon: LineIcons.cloud,
                      onSaved: (String? value) {
                        websiteUrl = value;
                      },
                    ),
                    FormFieldWidget(
                      name: "Email",
                      hintText: "mail@website.com",
                      textInputType: InputType.EMAIL,
                      prefixIcon: LineIcons.envelope,
                      onSaved: (String? value) {
                        email = value;
                      },
                    ),
                    FormFieldWidget(
                      name: "Password",
                      hintText: "Min 8 characters",
                      obscureText: true,
                      textInputType: InputType.PASSWORD,
                      prefixIcon: LineIcons.lock,
                      onSaved: (String? value) {
                        password = value;
                      },
                    ),
                  ],
                ),
                Gallery(
                  title: "Select Category",
                  name: "Category",
                  items: AppData.categories,
                  isAssetImages: true,
                  isMutable: false,
                  width: 200.0,
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
                  onSelectGalleryItem: (int selectedIndex) {
                    category = AppData.categories[selectedIndex];
                  },
                ),
                Consumer<VaultRecordsController>(
                  builder: (
                    BuildContext context,
                    VaultRecordsController vaultRecordsController,
                    _,
                  ) {
                    return FormSubmitBtn(
                      title: "Create New Login",
                      formKey: formKey,
                      onSubmit: () {
                        AuthRecord newAuthRecord = AuthRecord(
                          id: Uuid().v1(),
                          recordType: RecordType.AUTH.value,
                          userID: Uuid().v1(),
                          category: category?.toJson(),
                          createdAt: DateTime.now(),
                          websiteUrl: websiteUrl!,
                          email: email!,
                          password: password!,
                        );
                        vaultRecordsController.addRecord(
                            key: newAuthRecord.id, record: newAuthRecord);

                        Navigator.of(context).pop();

                        ScaffoldMessenger.of(context).showSnackBar(
                          snackbarWidget(
                            context: context,
                            title: "Created New Login",
                            actionLabel: "Undo",
                            actionOnPressed: () {
                              vaultRecordsController
                                  .deleteRecord(newAuthRecord.id);
                            },
                          ),
                        );
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
