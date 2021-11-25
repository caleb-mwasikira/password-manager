import 'package:password_manager/entities/enums.dart';

/// A [Record] is a document that can be stored in a [Vault]
///
/// All records must have a unique id, type, userID of their owner, createdAt
/// and expiresAt time periods.
abstract class Record {
  final String id;
  final RecordType recordType;
  String? keyID;
  String userID;
  Map<String, dynamic>? category;
  EncryptionType? encryptionType;
  final DateTime createdAt;

  Record({
    required this.id,
    required this.recordType,
    this.keyID,
    required this.userID,
    this.category,
    this.encryptionType,
    required this.createdAt,
  });
}
