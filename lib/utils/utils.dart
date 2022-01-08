import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

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

SnackBar snackbarWidget(BuildContext context) {
  return SnackBar(
    backgroundColor: Colors.lightBlueAccent,
    content: Container(
      height: 20.0,
      child: Center(
        child: Text(
          "File Selection Cancelled By User",
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: Colors.white),
        ),
      ),
    ),
  );
}

/// Lets the user select an image from their device.
Future<String?> selectImageFromDisk({
  required BuildContext context,
}) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['jpg', 'png', 'jpeg'],
  );

  String? selectedFile = result?.files.single.path;

  if (selectedFile == null) {
    ScaffoldMessenger.of(context).showSnackBar(snackbarWidget(context));
  }

  return selectedFile;
}

Future<List<String?>?> selectMultipleImagesFromDisk({
  required BuildContext context,
}) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['jpg', 'png', 'jpeg'],
    allowMultiple: true,
  );

  List<String?>? selectedFiles =
      result?.files.map((platformFile) => platformFile.path).toList();

  if (selectedFiles == null) {
    ScaffoldMessenger.of(context).showSnackBar(snackbarWidget(context));
  }

  return selectedFiles;
}

String getRandomString(int length) {
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890!@#\$%^&*()';
  Random _rnd = Random();

  return String.fromCharCodes(
    Iterable.generate(
      length,
      (_) => _chars.codeUnitAt(
        _rnd.nextInt(_chars.length),
      ),
    ),
  );
}

void main(List<String> args) {
  DateTime dateTime = isoStringToDatetime("2021-06-26T01:54:46Z");
  String dateAsString = dateTimeToString(dateTime);

  print('Datetime: $dateTime');
  print('ISO Datetime: ${dateTime.toIso8601String()}');
  print('Human Readable Datetime: $dateAsString');
}
