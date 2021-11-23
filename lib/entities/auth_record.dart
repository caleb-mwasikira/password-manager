import 'package:password_manager/entities/enums.dart';
import 'package:password_manager/entities/record.dart';
import 'package:password_manager/utils/enum_extension.dart';
import 'package:password_manager/utils/utils.dart';

/// An [AuthRecord] is a [Record] which stores website authentication data.
/// e.g. website urls, usernames, emails and their associative passwords.
class AuthRecord implements Record {
  final String id;
  final RecordType recordType;
  String? keyID;
  String userID;
  final String vaultID;
  Map<String, dynamic>? category;
  List? groups;
  EncryptionType? encryptionType;
  final DateTime createdAt;
  DateTime? expiresAt;

  String websiteUrl;
  String email;
  String password;

  AuthRecord({
    required this.id,
    required this.recordType,
    this.keyID,
    required this.userID,
    required this.vaultID,
    this.category,
    this.groups,
    this.encryptionType,
    required this.createdAt,
    this.expiresAt,
    required this.websiteUrl,
    required this.email,
    required this.password,
  });

  factory AuthRecord.fromJson(Map json) {
    return AuthRecord(
      id: json['id'],
      recordType:
          RecordType.values.firstWhere((e) => e.value == json['record_type']),
      keyID: json['key_id'],
      userID: json['user_id'],
      vaultID: json['vault_id'],
      category: json['category'],
      groups: json['groups'],
      encryptionType: EncryptionType.values
          .firstWhere((e) => e.value == json['encryption_type']),
      createdAt: isoStringToDatetime(json['created_at']),
      expiresAt: isoStringToDatetime(json['expires_at']),
      websiteUrl: json['website_url'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'record_type': recordType.toString(),
      'key_id': keyID,
      'user_id': userID,
      'vault_id': vaultID,
      'category': category,
      'groups': groups,
      'encryption_type': encryptionType.toString(),
      'created_at': createdAt.toIso8601String(),
      'expires_at': expiresAt?.toIso8601String(),
      'website_url': websiteUrl,
      'email': email,
      'password': password,
    };
  }
}
