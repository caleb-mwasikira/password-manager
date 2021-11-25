import 'package:password_manager/entities/enums.dart';
import 'package:password_manager/entities/record.dart';
import 'package:password_manager/utils/enum_extension.dart';
import 'package:password_manager/utils/utils.dart';

/// The [Vault] class is a representation of a vault in real life.
/// It holds [Record]s in a secure container which can be locked and unlocked
/// by an owner/group of owners.
class Vault {
  final String id;
  final String userID; // ID of the user who created the vault.
  final EncryptionType encryptionType;
  List<String>? owners; // List of users allowed to access this vault if any.
  Map<String, dynamic> key;
  final DateTime createdAt;
  List<Map> records; // A list of records being stored in the vault.

  Vault({
    required this.id,
    this.owners,
    required this.userID,
    required this.encryptionType,
    required this.key,
    required this.createdAt,
    required this.records,
  });

  factory Vault.fromJson(Map<String, dynamic> json) {
    return Vault(
      id: json['id'],
      owners: json['owners'],
      userID: json['user_id'],
      encryptionType: EncryptionType.values
          .firstWhere((e) => e.value == json['encryption_type']),
      key: json['key'],
      createdAt: isoStringToDatetime(json['created_at']),
      records: json['records'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "owners": owners,
      "user_id": userID,
      "encryption_mode": encryptionType.toString(),
      "key": key,
      "created_at": createdAt.toIso8601String(),
      "records": records,
    };
  }
}
