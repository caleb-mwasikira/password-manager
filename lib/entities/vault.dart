import 'package:password_manager/entities/record.dart';
import 'package:password_manager/utils/utils.dart';

enum EncryptionStandard {
  AES_256,
  RSA,
}

/// The [Vault] class is a representation of a vault in real life.
/// It holds [Record]s in a secure container which can be locked and unlocked
/// by an owner/group of owners.
class Vault {
  final String id;
  String? category;
  List<String>? groups; // Groups of users allowed to access this vault if any.
  final String userID; // ID of the user who created the vault.
  final EncryptionStandard
      encryptionMode; // Encryption standard used to lock and unlock the vault.
  Map<String, dynamic> password;
  Map<String, dynamic>? keys;
  final DateTime createdAt;
  DateTime? expiresAt;
  List<Map> data; // A list of records being stored in the vault.

  Vault({
    required this.id,
    this.category,
    this.groups,
    required this.userID,
    required this.encryptionMode,
    required this.password,
    this.keys,
    required this.createdAt,
    this.expiresAt,
    required this.data,
  });

  factory Vault.fromJson(Map<String, dynamic> json) {
    return Vault(
      id: json['id'],
      category: json['category'],
      groups: json['groups'],
      userID: json['user_id'],
      encryptionMode: EncryptionStandard.values[json['encryption_mode']],
      password: json['password'],
      keys: json['keys'],
      createdAt: isoStringToDatetime(json['created_at']),
      expiresAt: isoStringToDatetime(json['expires_at']),
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "category": category,
      "groups": groups,
      "user_id": userID,
      "encryption_mode": encryptionMode.toString(),
      "password": password,
      "keys": keys,
      "created_at": createdAt.toIso8601String(),
      "expires_at": expiresAt?.toIso8601String(),
      "data": data,
    };
  }
}
