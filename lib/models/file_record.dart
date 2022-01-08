import 'dart:typed_data';
import 'package:hive/hive.dart';

import 'package:password_manager/controllers/hive_boxes.dart';
import 'package:password_manager/models/record.dart';
import 'package:password_manager/utils/utils.dart';

part 'file_record.g.dart';

/// A [FileRecord] is a [Record] which stores encrypted file data.
@HiveType(typeId: HiveBoxes.FILE_RECORDS_TYPEID)
class FileRecord extends HiveObject implements Record {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String recordType;
  @HiveField(2)
  String? keyID;
  @HiveField(3)
  String userID;
  @HiveField(4)
  Map<String, dynamic>? category;
  @HiveField(5)
  String? encryptionType;
  @HiveField(6)
  final DateTime createdAt;

  @HiveField(7)
  String fileName;
  @HiveField(8)
  String fileSize;
  @HiveField(9)
  String fileDesc;
  @HiveField(10)
  Uint8List fileContents;

  FileRecord({
    required this.id,
    required this.recordType,
    this.keyID,
    required this.userID,
    this.category,
    this.encryptionType,
    required this.createdAt,
    required this.fileName,
    required this.fileSize,
    required this.fileDesc,
    required this.fileContents,
  });

  factory FileRecord.fromJson(Map json) {
    String _fileContents = json['file_contents'];

    return FileRecord(
      id: json['id'],
      recordType: json['record_type'],
      keyID: json['key_id'],
      userID: json['user_id'],
      category: json['category'],
      encryptionType: json['encryption_type'],
      createdAt: isoStringToDatetime(json['created_at']),
      fileName: json['file_name'],
      fileSize: json['file_size'],
      fileDesc: json['file_desc'],
      fileContents: Uint8List.fromList(_fileContents.codeUnits),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'record_type': recordType,
      'key_id': keyID,
      'user_id': userID,
      'category': category,
      'encryption_type': encryptionType,
      'created_at': createdAt.toIso8601String(),
      'file_name': fileName,
      'file_size': fileSize,
      'file_desc': fileDesc,
      'file_contents': fileContents.buffer.toString(),
    };
  }
}
