import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:line_icons/line_icons.dart';

import 'package:password_manager/entities/enums.dart';
import 'package:password_manager/entities/file_record.dart';
import 'package:password_manager/themes/app_theme_data.dart';
import 'package:password_manager/utils/utils.dart';
import 'package:password_manager/widgets/avatars/file_record_avatar.dart';
import 'package:password_manager/utils/enum_extension.dart';

// ignore: must_be_immutable
class FileRecordWidget extends StatefulWidget {
  final FileRecord fileRecord;
  final bool isSelected;

  FileRecordWidget({
    Key? key,
    required this.fileRecord,
    this.isSelected = false,
  }) : super(key: key);

  @override
  _FileRecordWidgetState createState() => _FileRecordWidgetState();
}

class _FileRecordWidgetState extends State<FileRecordWidget> {
  bool isProcessingFile = false;

  TextStyle? onHoverTextStyle() {
    return widget.isSelected
        ? Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white)
        : Theme.of(context).textTheme.bodyText1;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                      child: FileRecordAvatar(
                        fileType: FileType.values.firstWhereOrNull(
                          (e) => e.list.contains(
                              widget.fileRecord.fileName.split('.').last),
                        ),
                        isSelected: widget.isSelected,
                        selectedColor: Colors.white,
                        iconSize: AppThemeData.iconSizeLarge,
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
                    color: widget.isSelected
                        ? AppThemeData.whiteColor
                        : AppThemeData.textColor,
                    icon: Icon(LineIcons.lock),
                  ),
                ),
              ],
            ),
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
                          color: widget.isSelected
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
                      style: widget.isSelected
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
    );
  }
}
