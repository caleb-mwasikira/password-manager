import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:password_manager/controllers/vault_records_controller.dart';
import 'package:password_manager/utils/enums.dart';
import 'package:password_manager/utils/enum_extension.dart';
import 'package:password_manager/models/auth_record.dart';
import 'package:password_manager/models/file_record.dart';
import 'package:password_manager/themes/app_theme_data.dart';
import 'package:password_manager/widgets/vault_records/auth_record_widget.dart';
import 'package:password_manager/widgets/vault_records/file_record_widget.dart';

class VaultRecords extends StatefulWidget {
  VaultRecords({Key? key}) : super(key: key);

  @override
  _VaultRecordsState createState() => _VaultRecordsState();
}

class _VaultRecordsState extends State<VaultRecords> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Consumer<VaultRecordsController>(
        builder: (BuildContext context, vaultRecordsController, _) {
          List _vaultRecords = vaultRecordsController.records;

          return Container(
            margin: EdgeInsets.all(10.0),
            child: ListView.builder(
              itemCount: _vaultRecords.length,
              itemBuilder: (BuildContext context, int index) {
                var _vaultRecord = _vaultRecords[index];
                bool _isSelected =
                    vaultRecordsController.selectedRecord == _vaultRecord;

                return Card(
                  elevation: 2.0,
                  color: _isSelected ? Colors.lightBlueAccent : Colors.white,
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      vaultRecordsController.selectRecord(_vaultRecord.id);
                    },
                    borderRadius: AppThemeData.borderRadiusSmall,
                    child: _vaultRecord.recordType == RecordType.AUTH.value
                        ? AuthRecordWidget(
                            key: ValueKey(_vaultRecord.id),
                            authRecord: _vaultRecord as AuthRecord,
                            isSelected: _isSelected,
                          )
                        : FileRecordWidget(
                            key: ValueKey(_vaultRecord.id),
                            fileRecord: _vaultRecord as FileRecord,
                            isSelected: _isSelected,
                          ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
