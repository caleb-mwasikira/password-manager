// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthRecordAdapter extends TypeAdapter<AuthRecord> {
  @override
  final int typeId = 1;

  @override
  AuthRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthRecord(
      id: fields[0] as String,
      recordType: fields[1] as String,
      keyID: fields[2] as String?,
      userID: fields[3] as String,
      category: (fields[4] as Map?)?.cast<String, dynamic>(),
      encryptionType: fields[5] as String?,
      createdAt: fields[6] as DateTime,
      websiteUrl: fields[7] as String,
      email: fields[8] as String,
      password: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AuthRecord obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.recordType)
      ..writeByte(2)
      ..write(obj.keyID)
      ..writeByte(3)
      ..write(obj.userID)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.encryptionType)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.websiteUrl)
      ..writeByte(8)
      ..write(obj.email)
      ..writeByte(9)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
