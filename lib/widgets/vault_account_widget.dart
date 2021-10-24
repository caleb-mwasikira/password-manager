import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: CircleAvatar(
              radius: 20.0,
              foregroundImage: AssetImage('assets/images/users/julian-wan-WNoLnJo7tS8-unsplash.jpg'),
            ),
          ),

          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              decoration: BoxDecoration(
                color: CustomColors.backgroundColotWhiteShade1,
                borderRadius: BorderRadius.circular(10.0),
              ),
              width: 200.0,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.vaultAccount.category,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: CustomColors.backgroundColorBlack,
                        ),
                      ),
                      TextFormField(
                        initialValue: widget.vaultAccount.email,
                        readOnly: true,
                        style: TextStyle(fontSize: 13.0),
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
                              decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none
                              ),
                            ),
                          ),
                          Container(
                              width: 20.0,
                              height: 20.0,
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              child: GestureDetector(
                                onTap: () {
                                  print("copy password btn was clicked");
                                },
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: Icon(
                                    Icons.copy_rounded,
                                    size: 14.0,
                                    color: Colors.grey,
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
                                color: Colors.grey,
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
    );
  }
}

