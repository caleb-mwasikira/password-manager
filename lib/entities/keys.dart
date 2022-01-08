import 'dart:typed_data';

import 'package:password_manager/utils/enums.dart';

abstract class Key {
  final String id;
  String? desc;
  final EncryptionType keyType;

  Key({required this.id, this.desc, required this.keyType});
}

class AsymmetricKey implements Key {
  final String id;
  String? desc;
  final EncryptionType keyType;
  Uint8List idRSAPub;
  Uint8List idRSAPriv;

  AsymmetricKey({
    required this.id,
    this.desc,
    this.keyType = EncryptionType.RSA,
    required this.idRSAPriv,
    required this.idRSAPub,
  });

  factory AsymmetricKey.fromJson(Map json) {
    String _idRSAPriv = json['id_rsa_priv'];
    String _idRSAPub = json['id_rsa_pub'];

    return AsymmetricKey(
      id: json['id'],
      desc: json['desc'],
      keyType: EncryptionType.values[json['key_type']],
      idRSAPriv: Uint8List.fromList(_idRSAPriv.codeUnits),
      idRSAPub: Uint8List.fromList(_idRSAPub.codeUnits),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'desc': desc,
      'key_type': keyType.toString(),
      'id_rsa_priv': idRSAPriv.buffer.toString(),
      'id_rsa_pub': idRSAPub.buffer.toString(),
    };
  }
}

class SymmetricKey implements Key {
  final String id;
  String? desc;
  final EncryptionType keyType;
  String hash;
  String salt;

  SymmetricKey({
    required this.id,
    this.desc,
    this.keyType = EncryptionType.AES_256,
    required this.hash,
    required this.salt,
  });

  factory SymmetricKey.fromJson(Map json) {
    return SymmetricKey(
      id: json['id'],
      desc: json['desc'],
      keyType: EncryptionType.values[json['key_type']],
      hash: json['hash'],
      salt: json['salt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'desc': desc,
      'key_type': keyType.toString(),
      'hash': hash,
      'salt': salt,
    };
  }
}
