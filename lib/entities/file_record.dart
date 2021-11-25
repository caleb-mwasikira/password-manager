import 'dart:typed_data';

import 'package:password_manager/entities/enums.dart';
import 'package:password_manager/entities/record.dart';
import 'package:password_manager/utils/enum_extension.dart';
import 'package:password_manager/utils/utils.dart';

/// A [FileRecord] is a [Record] which stores encrypted file data.
class FileRecord implements Record {
  final String id;
  final RecordType recordType;
  String? keyID;
  String userID;
  Map<String, dynamic>? category;
  EncryptionType? encryptionType;
  final DateTime createdAt;

  String fileName;
  String fileSize;
  String fileDesc;
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
      recordType:
          RecordType.values.firstWhere((e) => e.value == json['record_type']),
      keyID: json['key_id'],
      userID: json['user_id'],
      category: json['category'],
      encryptionType: EncryptionType.values
          .firstWhere((e) => e.value == json['encryption_type']),
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
      'record_type': recordType.toString(),
      'key_id': keyID,
      'user_id': userID,
      'category': category,
      'encryption_type': encryptionType.toString(),
      'created_at': createdAt.toIso8601String(),
      'file_name': fileName,
      'file_size': fileSize,
      'file_desc': fileDesc,
      'file_contents': fileContents.buffer.toString(),
    };
  }
}
