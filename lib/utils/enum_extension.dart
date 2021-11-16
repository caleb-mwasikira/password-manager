import 'package:password_manager/entities/enums.dart';

extension RecordTypeValue on RecordType {
  String get value => this.toString().split('.').last;
}

extension EncryptionTypeValue on EncryptionType {
  String get value => this.toString().split('.').last;
}
