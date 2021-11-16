import 'package:intl/intl.dart';

/// Cast dynamic variable into type T
T? cast<T>(variableName) => variableName is T ? variableName : null;

/// Converts an ISO8601 date string into a DateTime object
DateTime isoStringToDatetime(String dateTime) {
  DateFormat dateFormatter = DateFormat('yyyy-MM-dd HH:mm:ss');
  String parsedDateTime = dateTime.replaceFirst('Z', '').split('T').join(' ');
  return dateFormatter.parse(parsedDateTime);
}

/// Converts a DateTime into human readable date string.
String dateTimeToString(DateTime dateTime) {
  DateFormat dateFormatter = DateFormat('d MMM, yyyy HH:mm:ss aa');
  String parsedDateTime = dateFormatter.format(dateTime);
  return parsedDateTime;
}

void main(List<String> args) {
  DateTime dateTime = isoStringToDatetime("2021-06-26T01:54:46Z");
  String dateAsString = dateTimeToString(dateTime);

  print('Datetime: $dateTime');
  print('ISO Datetime: ${dateTime.toIso8601String()}');
  print('Human Readable Datetime: $dateAsString');
}
