import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_manager/data/app_data.dart';

import 'package:password_manager/entities/auth_record.dart';
import 'package:password_manager/entities/enums.dart';
import 'package:password_manager/entities/file_record.dart';
import 'package:password_manager/themes/app_theme_data.dart';
import 'package:password_manager/widgets/vault_record_widgets/auth_record_widget.dart';
import 'package:password_manager/widgets/vault_record_widgets/file_record_widget.dart';
import 'package:password_manager/utils/enum_extension.dart';

/// The [VaultRecords] displays a previewed list of all the records stored
/// in the currently logged in user account.
class VaultRecords extends StatefulWidget {
  const VaultRecords({
    Key? key,
  }) : super(key: key);

  @override
  _VaultRecordsState createState() => _VaultRecordsState();
}

class _VaultRecordsState extends State<VaultRecords> {
  Future<List>? vaultRecords;
  int selectedIndex = 0;

  @override
  void initState() {
    setState(() {
      vaultRecords =
          AppData.fetchAssetData(dataDir: 'assets/data/records.json');
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FutureBuilder(
        future: vaultRecords,
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            List vaultRecords = snapshot.data!;

            return vaultRecords.isEmpty
                ? Center(
                    child: Container(
                      width: 400.0,
                      height: 400.0,
                      child: Column(
                        children: [
                          Image.asset("assets/images/icons/no_data_found.png"),
                          Container(
                            child: Text(
                              "You have zero records saved",
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.all(20.0),
                    child: ListView.builder(
                      itemCount: vaultRecords.length,
                      cacheExtent: 800.0,
                      itemBuilder: (BuildContext context, int index) {
                        final Map vaultRecord = vaultRecords[index];

                        final RecordType _recordType = RecordType.values
                            .firstWhere(
                                (e) => e.value == vaultRecord["record_type"]);

                        final bool _isSelected = selectedIndex == index;
                        final Color _selectedColor =
                            _isSelected ? Colors.lightBlueAccent : Colors.white;

                        return Card(
                          elevation: _isSelected ? 4.0 : 1.0,
                          color: _selectedColor,
                          shadowColor: _selectedColor,
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 30.0),
                          child: InkWell(
                            hoverColor: Colors.transparent,
                            focusColor: Colors.blueAccent,
                            highlightColor: Colors.blueAccent,
                            onTap: () {
                              print(
                                  '[Record] type [${_recordType.toString()}] was clicked');

                              if (this.mounted) {
                                setState(() {
                                  selectedIndex = index;
                                });
                              }
                            },
                            borderRadius: AppThemeData.borderRadius,
                            child: _recordType == RecordType.AUTH
                                ? AuthRecordWidget(
                                    authRecord:
                                        AuthRecord.fromJson(vaultRecord),
                                    isSelected: _isSelected,
                                  )
                                : FileRecordWidget(
                                    fileRecord:
                                        FileRecord.fromJson(vaultRecord),
                                    isSelected: _isSelected,
                                  ),
                          ),
                        );
                      },
                    ),
                  );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
