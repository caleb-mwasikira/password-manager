class User {
  final String id;
  String username;
  String email;
  String password;
  String? profilePic;
  List<String>? groups;
  List<Map<String, dynamic>>? keys;
  List<Map<String, dynamic>?> vault;

  User({
    required this.id,
    this.username = "Guest",
    required this.email,
    required this.password,
    this.profilePic,
    this.groups,
    this.keys,
    required this.vault,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      profilePic: json['profile_pic'],
      groups: json['groups'],
      keys: json['keys'],
      vault: json['vault'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'profile_pic': profilePic,
      'groups': groups,
      'keys': keys,
      'vault': vault,
    };
  }
}
