import 'package:password_manager/utils/enums.dart';

extension RecordTypeExt on RecordType {
  String get value => this.toString().split('.').last;
}

extension EncryptionTypeExt on EncryptionType {
  String get value => this.toString().split('.').last;
}

extension FileTypeExt on FileType {
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
