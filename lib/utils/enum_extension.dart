import 'package:password_manager/entities/enums.dart';

extension RecordTypeValue on RecordType {
  String get value => this.toString().split('.').last;
}

extension EncryptionTypeValue on EncryptionType {
  String get value => this.toString().split('.').last;
}

extension FileTypeToList on FileType {
  List<String> get list {
    switch (this) {
      case FileType.AUDIO:
        return ['mp3', 'wav', 'avi'];

      case FileType.IMAGE:
        return ['png', 'jpeg', 'jpg', 'gif'];

      case FileType.VIDEO:
        return ['mp4', 'avi'];

      case FileType.CODE:
        return ['py', 'js', 'css', 'html', 'xml', 'kt', 'dart', 'go'];

      default:
        return ['doc', 'docx', 'pdf'];
    }
  }
}
