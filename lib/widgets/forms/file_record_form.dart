import 'package:flutter/material.dart';

class FileRecordForm extends StatefulWidget {
  final String title = "File Record";
  final double width, height;

  const FileRecordForm({
    Key? key,
    this.width = 400.0,
    this.height = 480.0,
  }) : super(key: key);

  @override
  _FileRecordFormState createState() => _FileRecordFormState();
}

class _FileRecordFormState extends State<FileRecordForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
        ],
      ),
    );
  }
}
