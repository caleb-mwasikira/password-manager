import 'package:password_manager/entities/enums.dart';

/// A [Record] is a document that can be stored in a [Vault]
///
/// All records must have a unique id, type, userID of their owner, createdAt
/// and expiresAt time periods.
class Record {
  final String id;
  final RecordType recordType;
  String? keyID;
  Map<String, dynamic>? category;
  List? groups;
  String? userID;
  EncryptionType? encryptionType;
  final DateTime createdAt;
  DateTime? expiresAt;

  Record({
    required this.id,
    required this.recordType,
    this.keyID,
    this.category,
    this.groups,
    this.userID,
    this.encryptionType,
    required this.createdAt,
    this.expiresAt,
  });
}
