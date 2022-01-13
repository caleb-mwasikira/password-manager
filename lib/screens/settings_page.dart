import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import 'package:password_manager/controllers/user_controller.dart';
import 'package:password_manager/models/user.dart';
import 'package:password_manager/themes/app_theme_data.dart';
import 'package:password_manager/widgets/record_detail.dart';
import 'package:password_manager/widgets/vault_records/confirmation_dialog.dart';
import 'package:password_manager/widgets/action_button.dart';
import 'package:password_manager/widgets/avatars/user_profile.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserController>(
          builder: (BuildContext context, UserController userController, _) {
        User currentUser = userController.currentlyLoggedInUser!;

        return Center(
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            margin: EdgeInsets.symmetric(vertical: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    children: [
                      ActionButton(
                        iconData: LineIcons.arrowLeft,
                        iconSize: AppThemeData.iconSizeMedium,
                        onPressed: () {
                          // Back button
                          Navigator.pop(context);
                        },
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          "My Accounts",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
                    ],
                  ),
                ),
                UserProfile(
                  user: currentUser,
                  isEditable: true,
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: AppThemeData.borderRadiusSmall,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RecordDetail(
                        title: "Display Name",
                        detail: currentUser.username ?? "Guest",
                      ),
                      RecordDetail(
                        title: "Email",
                        detail: currentUser.email,
                      ),
                      RecordDetail(
                        title: "Password",
                        detail: currentUser.password,
                      ),
                    ],
                  ),
                ),

                // Delete Account Button
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Delete account button was clicked

                      deleteAccount(
                        context,
                        userController: userController,
                        userAccount: currentUser,
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.redAccent,
                      ),
                      fixedSize: MaterialStateProperty.all<Size>(
                        Size(150.0, 40.0),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: AppThemeData.borderRadiusSmall,
                        ),
                      ),
                    ),
                    child: Text(
                      "Delete Account",
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  void deleteAccount(
    BuildContext context, {
    required UserController userController,
    required User userAccount,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: AppThemeData.borderRadiusSmall,
          ),
          content: ConfirmationDialog(
            title: "Delete this account?",
            onAccept: () {
              userController.deleteUserAccount(
                context: context,
                user: userAccount,
              );
            },
          ),
        );
      },
    );
  }
}
