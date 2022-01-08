import 'dart:io';
import 'package:flutter/material.dart';
import 'package:favicon/favicon.dart' as Fav;
import 'package:line_icons/line_icons.dart';
import 'package:network_to_file_image/network_to_file_image.dart';
import 'package:path/path.dart' as path;

import 'package:password_manager/controllers/app_data.dart';
import 'package:password_manager/themes/app_theme_data.dart';

// ignore: must_be_immutable
class AuthRecordAvatar extends StatefulWidget {
  final String? websiteUri;
  final double radius;

  final BoxShape? shape;

  AuthRecordAvatar({
    Key? key,
    required this.websiteUri,
    this.radius = 20.0,
    this.shape = BoxShape.circle,
  }) : super(key: key);

  @override
  State<AuthRecordAvatar> createState() => _AuthRecordAvatarState();
}

class _AuthRecordAvatarState extends State<AuthRecordAvatar> {
  late String iconsStorageDir;
  late Future<String?> websiteIcon;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      String _iconsStorageDir = await AppData.appIconsDir;

      setState(() {
        iconsStorageDir = _iconsStorageDir;
      });
    });

    setState(() {
      websiteIcon = _fetchWebsiteIcon(widget.websiteUri);
    });

    super.initState();
  }

  Future<String?> _fetchWebsiteIcon(String? uri) async {
    try {
      if (uri == null)
        throw Exception('Cannot fetch website icon from a null URL');

      print('Fetching website icon from URL $uri');
      Fav.Icon? iconUrl =
          await Fav.Favicon.getBest(uri, suffixes: ['png', 'ico']);
      return iconUrl?.url;
    } catch (_) {
      print('Failed to fetch website icon from $uri');
      return null;
    }
  }

  File _iconsDir(String filename) {
    String pathName = path.join(iconsStorageDir, filename);
    return File(pathName);
  }

  Widget get avatarErrorWidget {
    return Center(
      child: Icon(
        LineIcons.alternateFire,
        size: AppThemeData.iconsSizeMedium,
        color: Colors.grey,
      ),
    );
  }

  Widget get avatarLoadingWidget {
    return Center(
      child: Container(
        width: 25.0,
        height: 25.0,
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
        ),
      ),
    );
  }

  Widget avatarImage(String websiteIcon) {
    String fileName = Uri.parse(websiteIcon)
        .host
        .split('.')[1]; // from www.google.com we take google

    return Image(
      image: NetworkToFileImage(
        url: websiteIcon,
        file: _iconsDir(fileName),
        debug: true,
      ),
      errorBuilder: (context, error, stackTrace) => avatarErrorWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      elevation: 4.0,
      shape: widget.shape == BoxShape.circle
          ? CircleBorder()
          : RoundedRectangleBorder(
              borderRadius: AppThemeData.borderRadiusSmall),
      clipBehavior: Clip.hardEdge,
      child: Container(
        width: widget.radius,
        height: widget.radius,
        padding: EdgeInsets.all(4.0),
        child: FutureBuilder(
            future: websiteIcon,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return avatarLoadingWidget;
              } else if (snapshot.hasData) {
                String? _websiteIcon = snapshot.data;

                return _websiteIcon != null
                    ? avatarImage(_websiteIcon)
                    : avatarErrorWidget;
              } else {
                return avatarErrorWidget;
              }
            }),
      ),
    );
  }
}
