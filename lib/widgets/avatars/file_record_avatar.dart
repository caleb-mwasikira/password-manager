import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'package:password_manager/entities/enums.dart';
import 'package:password_manager/themes/app_theme_data.dart';

class FileRecordAvatar extends StatelessWidget {
  final FileType? fileType;

  final bool isSelected;
  final Color selectedColor;
  final double iconSize;

  const FileRecordAvatar({
    Key? key,
    required this.fileType,
    this.isSelected = false,
    this.selectedColor = Colors.lightBlueAccent,
    this.iconSize = AppThemeData.iconSizeLarge,
  }) : super(key: key);

  /// Returns an icon matching a given file type.
  IconData get _fileIcon {
    IconData _fileIcon;

    switch (fileType) {
      case FileType.IMAGE:
        _fileIcon = LineIcons.imageFile;
        break;
      case FileType.AUDIO:
        _fileIcon = LineIcons.audioFile;
        break;
      case FileType.VIDEO:
        _fileIcon = LineIcons.video;
        break;
      case FileType.CODE:
        _fileIcon = LineIcons.codeFile;
        break;
      default:
        _fileIcon = LineIcons.pdfFile;
    }

    return _fileIcon;
  }

  @override
  Widget build(BuildContext context) {
    return Icon(
      _fileIcon,
      size: iconSize,
      color: isSelected ? selectedColor : AppThemeData.textColor,
    );
  }
}
