import 'package:hive/hive.dart';

import 'package:password_manager/controllers/hive_boxes.dart';

part 'user.g.dart';

@HiveType(typeId: HiveBoxes.USERS_TYPEID)
class User extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  String? username;
  @HiveField(2)
  String email;
  @HiveField(3)
  String password;
  @HiveField(4)
  String? profilePic;
  @HiveField(5)
  String? vaultID;
  @HiveField(6)
  List<String>? keyIDs;

  User({
    required this.id,
    this.username = "Guest",
    required this.email,
    required this.password,
    this.profilePic,
    this.vaultID,
    this.keyIDs,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      profilePic: json['profile_pic'],
      vaultID: json['vault_id'],
      keyIDs: json['key_ids'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'profile_pic': profilePic,
      'vault_id': vaultID,
      'key_ids': keyIDs,
    };
  }
}
