import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'package:password_manager/entities/file_record.dart';
import 'package:password_manager/themes/app_theme_data.dart';
import 'package:password_manager/utils/utils.dart';
import 'package:password_manager/utils/enum_extension.dart';

class FileRecordWidget extends StatefulWidget {
  final FileRecord fileRecord;

  const FileRecordWidget({Key? key, required this.fileRecord})
      : super(key: key);

  @override
  _FileRecordWidgetState createState() => _FileRecordWidgetState();
}

class _FileRecordWidgetState extends State<FileRecordWidget> {
  bool onHover = false;
  bool isProcessingFile = false;

  TextStyle? onHoverTextStyle() {
    return onHover
        ? Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white)
        : Theme.of(context).textTheme.bodyText1;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.lightBlueAccent,
      focusColor: Colors.blueAccent,
      highlightColor: Colors.blueAccent,
      onTap: () {
        print('[FileRecordWidget] clicked');
      },
      onHover: (value) {
        if (this.mounted) {
          setState(() {
            onHover = value;
          });
        }
      },
      borderRadius: AppThemeData.borderRadius,
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Icon(
                          LineIcons.fileAlt,
                          size: AppThemeData.iconSizeLarge,
                          color:
                              onHover ? Colors.white : AppThemeData.textColor,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 150.0,
                            child: Text(
                              widget.fileRecord.fileName,
                              overflow: TextOverflow.ellipsis,
                              style: onHoverTextStyle(),
                            ),
                          ),
                          Text(
                            widget.fileRecord.encryptionType
                                .toString()
                                .split('.')
                                .last,
                            style: onHoverTextStyle(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: 20.0,
                    height: 20.0,
                    child: IconButton(
                      onPressed: () {
                        print('[AuthRecord] process file button was clicked');
                        setState(() {
                          isProcessingFile = !isProcessingFile;
                        });
                      },
                      padding: EdgeInsets.zero,
                      iconSize: AppThemeData.iconsSizeMedium,
                      color: onHover
                          ? AppThemeData.whiteColor
                          : AppThemeData.textColor,
                      icon: Icon(LineIcons.lock),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.fileRecord.fileSize,
                    style: onHoverTextStyle(),
                  ),
                  Text(
                    widget.fileRecord.fileDesc,
                    style: onHoverTextStyle(),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 0.1,
              color: onHover ? Colors.white : Colors.black,
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isProcessingFile
                      ? Container(
                          width: 20.0,
                          height: 20.0,
                          child: CircularProgressIndicator(
                            color: onHover
                                ? Colors.white
                                : AppThemeData.primaryColorDark,
                            strokeWidth: 1.0,
                          ),
                        )
                      : Container(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Created At",
                        style: onHover
                            ? Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(color: Colors.white)
                            : Theme.of(context).textTheme.bodyText2,
                      ),
                      Text(
                        dateTimeToString(widget.fileRecord.createdAt),
                        style: onHoverTextStyle(),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
