import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import 'package:password_manager/utils/utils.dart';
import 'package:password_manager/widgets/vault_records/confirmation_dialog.dart';
import 'package:password_manager/widgets/vault_records/record_detail.dart';
import 'package:password_manager/themes/app_theme_data.dart';
import 'package:password_manager/widgets/action_button.dart';
import 'package:password_manager/controllers/vault_records_controller.dart';
import 'package:password_manager/models/auth_record.dart';
import 'package:password_manager/widgets/vault_records/auth_record_widget.dart';

class SelectedRecord extends StatefulWidget {
  const SelectedRecord({Key? key}) : super(key: key);

  @override
  State<SelectedRecord> createState() => _SelectedRecordState();
}

class _SelectedRecordState extends State<SelectedRecord> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Consumer<VaultRecordsController>(
        builder: (BuildContext context, vaultRecordsController, _) {
          dynamic selectedRecord = vaultRecordsController.selectedRecord;
          String createdAtReadableDate = selectedRecord != null
              ? dateTimeToString(selectedRecord.createdAt)
              : "";

          return Container(
            margin: EdgeInsets.all(10.0),
            child: Center(
              child: selectedRecord == null
                  // ? Result(
                  //     imgUrl: "assets/images/display_art/no_data_found.png",
                  //     message: "No currently selected record",
                  //   )
                  ? SizedBox()
                  : Column(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AuthRecordWidget(
                                      authRecord: selectedRecord as AuthRecord,
                                      avatarRadius: 40.0,
                                      avatarShape: BoxShape.rectangle,
                                    ),
                                    Row(
                                      children: [
                                        ActionButton(
                                          iconData: LineIcons.alternatePencil,
                                          margin: EdgeInsets.all(10.0),
                                          backgroundColor: Colors.transparent,
                                          iconSize: AppThemeData.iconSizeMedium,
                                          tooltip: "Edit",
                                          onPressed: () {
                                            print(
                                                "Edit record ${selectedRecord.id} button was clicked");
                                          },
                                        ),
                                        ActionButton(
                                          iconData: LineIcons.trash,
                                          margin: EdgeInsets.all(10.0),
                                          backgroundColor: Colors.transparent,
                                          iconSize: AppThemeData.iconSizeMedium,
                                          tooltip: "Delete",
                                          onPressed: () {
                                            // Delete record button was clicked

                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  elevation: 0.0,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: AppThemeData
                                                        .borderRadiusSmall,
                                                  ),
                                                  content: ConfirmationDialog(
                                                    title: "Delete this login?",
                                                    onAccept: () {
                                                      vaultRecordsController
                                                          .deleteRecord(
                                                              selectedRecord
                                                                  .id);
                                                    },
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            RecordDetail(
                                              title: "Website Address",
                                              detail: selectedRecord.websiteUrl,
                                            ),
                                            RecordDetail(
                                              title: "Username",
                                              detail: selectedRecord.email,
                                              canBeCopied: true,
                                            ),
                                            RecordDetail(
                                              title: "Password",
                                              detail: selectedRecord.password,
                                              canBeCopied: true,
                                            ),
                                          ],
                                        ),
                                        Divider(),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Category: ${selectedRecord.category?['name']}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                            ),
                                            Text(
                                              "Encryption Type: ${selectedRecord.encryptionType}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                            ),
                                            Text(
                                              "Created At: $createdAtReadableDate",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}
