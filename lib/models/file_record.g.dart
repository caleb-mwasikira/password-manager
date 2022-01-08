// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FileRecordAdapter extends TypeAdapter<FileRecord> {
  @override
  final int typeId = 2;

  @override
  FileRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FileRecord(
      id: fields[0] as String,
      recordType: fields[1] as String,
      keyID: fields[2] as String?,
      userID: fields[3] as String,
      category: (fields[4] as Map?)?.cast<String, dynamic>(),
      encryptionType: fields[5] as String?,
      createdAt: fields[6] as DateTime,
      fileName: fields[7] as String,
      fileSize: fields[8] as String,
      fileDesc: fields[9] as String,
      fileContents: fields[10] as Uint8List,
    );
  }

  @override
  void write(BinaryWriter writer, FileRecord obj) {
    writer
      ..writeByte(11)
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
      ..write(obj.fileName)
      ..writeByte(8)
      ..write(obj.fileSize)
      ..writeByte(9)
      ..write(obj.fileDesc)
      ..writeByte(10)
      ..write(obj.fileContents);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FileRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
