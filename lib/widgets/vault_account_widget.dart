import 'package:flutter/material.dart';
import 'package:favicon/favicon.dart' as Fav;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clipboard/clipboard.dart';

import 'package:password_manager/models/vault_account.dart';
import 'package:password_manager/themes/custom_colors.dart';


// ignore: must_be_immutable
class VaultAccountWidget extends StatefulWidget {
  VaultAccount vaultAccount;

  VaultAccountWidget({ 
    Key? key,
    required this.vaultAccount,
  }) : super(key: key);

  @override
  _VaultAccountWidgetState createState() => _VaultAccountWidgetState();
}

class _VaultAccountWidgetState extends State<VaultAccountWidget> {
  String? _faviconUrl;
  bool onHover = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      Fav.Icon? iconUrl = await Fav.Favicon.getBest(widget.vaultAccount.url);

      if(this.mounted) {
        setState(() {
          _faviconUrl = iconUrl?.url;
        });
      }
      
      print(_faviconUrl);
    });
  }


  @override
  Widget build(BuildContext context) {
    Color onHoverTextColor = onHover ? Colors.white : CustomColors.backgroundColorBlack;

    return Container(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      decoration: BoxDecoration(
        color: onHover ? Colors.lightBlueAccent : CustomColors.backgroundColotWhiteShade1,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: InkWell(
        hoverColor: Colors.blueAccent,
        focusColor: Colors.lightBlue,
        onTap: () {
          print('vault account widget - ${widget.vaultAccount.url} clicked');
        },
        onHover: (value) {
          setState(() {
            onHover = value;
          });
        },
        borderRadius: BorderRadius.circular(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              padding: EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: CustomColors.backgroundColorWhite,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: vaultAccountIcon(_faviconUrl),
            ),
      
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                width: 200.0,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 200.0,
                          child: Text(
                            widget.vaultAccount.url,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: onHoverTextColor,
                            ),
                          ),
                        ),
                        TextFormField(
                          initialValue: widget.vaultAccount.email,
                          readOnly: true,
                          style: TextStyle(
                            fontSize: 13.0,
                            color: onHoverTextColor,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                initialValue: widget.vaultAccount.password['hash'],
                                readOnly: true,
                                obscureText: true,
                                obscuringCharacter: '*',
                                style: TextStyle(
                                  color: onHoverTextColor,
                                  letterSpacing: 2.0,
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Container(
                                width: 20.0,
                                height: 20.0,
                                margin: EdgeInsets.symmetric(horizontal: 10.0),
                                child: GestureDetector(
                                  onTap: () {
                                    FlutterClipboard.copy(widget.vaultAccount.password['hash'])
                                      .then((value) {
                                        print("copy password btn was clicked");
                                      });
                                  },
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Icon(
                                      Icons.copy_rounded,
                                      size: 14.0,
                                      color: onHoverTextColor,
                                    ),
                                  ),
                                ),
                            ),
                          ],
                        )
                      ],
                    ),
            
                    Positioned(
                      top: 0.0,
                      right: 0.0,
                      child: Container(
                            child: GestureDetector(
                              onTap: () {
                                print("edit vault account btn was clicked");
                              },
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: Icon(
                                  Icons.more_horiz,
                                  size: 14.0,
                                  color: onHoverTextColor,
                                ),
                              ),
                            ),
                        ),
                    ),
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container vaultAccountIcon(String? faviconUrl) {
    return Container(
      width: 25.0,
      height: 25.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200.0),
        child: FittedBox(
          fit: BoxFit.fill,
          child: faviconUrl != null ?
            CachedNetworkImage(
              imageUrl: faviconUrl,
              placeholder: (BuildContext context, String url)  {
                return Container(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(strokeWidth: 2.0),
                );
              },
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ) :
            Image.asset("assets/logos/Vault-logos_black.png"),
        ),
      ),
    );
  }
}

