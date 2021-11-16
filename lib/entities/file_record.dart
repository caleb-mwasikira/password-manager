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
  Map<String, dynamic>? category;
  List? groups;
  String? userID;
  EncryptionType? encryptionType;
  final DateTime createdAt;
  DateTime? expiresAt;

  String fileName;
  String fileSize;
  String fileDesc;
  Uint8List fileContents;

  FileRecord({
    required this.id,
    required this.recordType,
    this.keyID,
    this.category,
    this.groups,
    this.userID,
    this.encryptionType,
    required this.createdAt,
    this.expiresAt,
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
      category: json['category'],
      groups: json['groups'],
      userID: json['user_id'],
      encryptionType: EncryptionType.values
          .firstWhere((e) => e.value == json['encryption_type']),
      createdAt: isoStringToDatetime(json['created_at']),
      expiresAt: isoStringToDatetime(json['expires_at']),
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
      'category': category,
      'groups': groups,
      'user_id': userID,
      'encryption_type': encryptionType.toString(),
      'created_at': createdAt.toIso8601String(),
      'expires_at': expiresAt?.toIso8601String(),
      'file_name': fileName,
      'file_size': fileSize,
      'file_desc': fileDesc,
      'file_contents': fileContents.buffer.toString(),
    };
  }
}
