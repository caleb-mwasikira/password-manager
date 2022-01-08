import 'package:hive/hive.dart';

import 'package:password_manager/controllers/hive_boxes.dart';
import 'package:password_manager/models/record.dart';
import 'package:password_manager/utils/utils.dart';

part 'auth_record.g.dart';

/// An [AuthRecord] is a [Record] which stores website authentication data.
/// e.g. website urls, usernames, emails and their associative passwords.
@HiveType(typeId: HiveBoxes.AUTH_RECORDS_TYPEID)
class AuthRecord extends HiveObject implements Record {
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
  String websiteUrl;
  @HiveField(8)
  String email;
  @HiveField(9)
  String password;

  AuthRecord({
    required this.id,
    required this.recordType,
    this.keyID,
    required this.userID,
    this.category,
    this.encryptionType,
    required this.createdAt,
    required this.websiteUrl,
    required this.email,
    required this.password,
  });

  factory AuthRecord.fromJson(Map json) {
    return AuthRecord(
      id: json['id'],
      recordType: json['record_type'],
      keyID: json['key_id'],
      userID: json['user_id'],
      category: json['category'],
      encryptionType: json['encryption_type'],
      createdAt: isoStringToDatetime(json['created_at']),
      websiteUrl: json['website_url'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'record_type': recordType,
      'key_id': keyID,
      'user_id': userID,
      'category': category,
      'encryption_type': encryptionType,
      'created_at': createdAt.toIso8601String(),
      'website_url': websiteUrl,
      'email': email,
      'password': password,
    };
  }
}
