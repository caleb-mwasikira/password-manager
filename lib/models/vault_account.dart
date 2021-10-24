
enum VaultType {
  Auth,
  Files
}


class VaultAccount {
  String? type;
  String category;
  String username;
  String email;
  Map<String, dynamic> password;
  List vault;
  String? url;
  String createdAt;
  String? expiresAt;

  VaultAccount({
    this.type = 'Auth',
    this.category = 'Default',
    required this.username,
    required this.email,
    required this.password,
    required this.vault,
    this.url,
    required this.createdAt,
    this.expiresAt,
  });

  factory VaultAccount.fromJson(Map<String, dynamic> json) {
    return VaultAccount(
      type: json['type'],
      category: json['category'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      vault: json['vault'],
      url: json['url'],
      createdAt: json['createdAt'],
      expiresAt: json['expiresAt'],
    );
  }

}