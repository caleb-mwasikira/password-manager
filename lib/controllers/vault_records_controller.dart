import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:password_manager/controllers/hive_boxes.dart';
import 'package:password_manager/models/auth_record.dart';
import 'package:password_manager/models/file_record.dart';

class VaultRecordsController extends ChangeNotifier {
  final List<Box> recordBoxes;

  Map _records = {};
  List get records => _records.values.toList();

  String? selectedRecordID;
  dynamic get selectedRecord => _records[selectedRecordID];

  VaultRecordsController({required this.recordBoxes}) {
    recordBoxes.forEach((box) {
      _records.addAll(box.toMap());
    });
  }

  Box? _getBox(String recordType) {
    switch (recordType) {
      case "AUTH":
        return Hive.box<AuthRecord>(HiveBoxes.authRecords);
      default:
        return Hive.box<FileRecord>(HiveBoxes.fileRecords);
    }
  }

  void selectRecord(String key) {
    selectedRecordID = key;
    notifyListeners();
  }

  void addRecord({required String key, required dynamic record}) {
    Box? box = _getBox(record.recordType);

    box?.put(key, record);
    _records[key] = record;

    notifyListeners();
  }

  void updateRecord({required String key, required dynamic updatedRecord}) {
    Box? box = _getBox(updatedRecord.recordType);

    box?.put(key, updatedRecord);
    _records[key] = updatedRecord;

    notifyListeners();
  }

  void deleteRecord(String key) {
    dynamic record = _records[key];
    Box? box = _getBox(record.recordType);

    box?.delete(key);
    _records.remove(key);

    notifyListeners();
  }
}
