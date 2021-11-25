import 'package:flutter/material.dart';
import 'package:favicon/favicon.dart' as Fav;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:line_icons/line_icons.dart';

import 'package:password_manager/themes/app_theme_data.dart';

// ignore: must_be_immutable
class AuthRecordAvatar extends StatefulWidget {
  final String? websiteUri;
  final double radius;

  AuthRecordAvatar({
    Key? key,
    required this.websiteUri,
    this.radius = 20.0,
  }) : super(key: key);

  @override
  _AuthRecordAvatarState createState() => _AuthRecordAvatarState();
}

class _AuthRecordAvatarState extends State<AuthRecordAvatar> {
  String? websiteIcon;

  @override
  void initState() {
    if (widget.websiteUri != null) {
      fetchWebsiteIcon(widget.websiteUri!);
    }

    super.initState();
  }

  void fetchWebsiteIcon(String uri) async {
    try {
      Fav.Icon? iconUrl =
          await Fav.Favicon.getBest(uri, suffixes: ['png', 'ico']);
      if (this.mounted) {
        setState(() {
          websiteIcon = iconUrl?.url;
        });
      }
    } catch (_) {
      print('Failed to fetch website icon from $uri');
    }
  }

  Widget recordAvatarErr() {
    return Center(
      child: Tooltip(
        message: "Failed to load website icon",
        child: Icon(
          LineIcons.bug,
          size: AppThemeData.iconsSizeMedium,
          color: Colors.grey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      elevation: 4.0,
      shape: CircleBorder(),
      clipBehavior: Clip.hardEdge,
      child: Container(
        width: widget.radius,
        height: widget.radius,
        padding: EdgeInsets.all(4.0),
        child: websiteIcon != null
            ? CachedNetworkImage(
                imageUrl: websiteIcon!,
                placeholder: (BuildContext context, String url) {
                  return Container(
                    width: widget.radius,
                    height: widget.radius,
                    child: CircularProgressIndicator(strokeWidth: 1.0),
                  );
                },
                errorWidget: (context, url, error) {
                  return recordAvatarErr();
                },
              )
            : recordAvatarErr(),
      ),
    );
  }
}
