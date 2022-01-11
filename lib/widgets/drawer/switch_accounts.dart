import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:password_manager/widgets/action_button.dart';
import 'package:provider/provider.dart';

import 'package:password_manager/controllers/user_controller.dart';
import 'package:password_manager/models/user.dart';
import 'package:password_manager/themes/app_theme_data.dart';
import 'package:password_manager/widgets/avatars/user_profile.dart';

class SwitchAccounts extends StatefulWidget {
  const SwitchAccounts({Key? key}) : super(key: key);

  @override
  _SwitchAccountsState createState() => _SwitchAccountsState();
}

class _SwitchAccountsState extends State<SwitchAccounts> {
  CarouselController carouselController = new CarouselController();
  String? selectedAccountEmail;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Consumer<UserController>(
          builder: (BuildContext context, UserController userController, _) {
        List<User> userAccounts = userController.users
          ..remove(userController.currentlyLoggedInUser);

        return Container(
          width: 350.0,
          height: 350.0,
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: AppThemeData.borderRadiusSmall,
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Current [UserProfile]
                  UserProfile(
                    user: userController.currentlyLoggedInUser,
                    axis: Axis.vertical,
                  ),

                  RotatedBox(
                    quarterTurns: 1,
                    child: Icon(LineIcons.alternateExchange),
                  ),

                  // Available [UserProfile]s
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 40.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CarouselSlider(
                          carouselController: carouselController,
                          options: CarouselOptions(
                            height: 150.0,
                            disableCenter: true,
                            enableInfiniteScroll: false,
                          ),
                          items: userAccounts.map((userAccount) {
                            return Builder(
                              builder: (BuildContext context) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedAccountEmail = userAccount.email;
                                    });
                                  },
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5.0),
                                      child: UserProfile(
                                        user: userAccount,
                                        axis: Axis.vertical,
                                        isSelected: userAccount.email ==
                                            selectedAccountEmail,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                        userAccounts.length > 1
                            ? Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ActionButton(
                                      iconData:
                                          Icons.arrow_back_ios_new_rounded,
                                      onPressed:
                                          carouselController.previousPage,
                                    ),
                                    ActionButton(
                                      iconData: Icons.arrow_forward_ios_rounded,
                                      onPressed: carouselController.nextPage,
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox.shrink()
                      ],
                    ),
                  ),
                ],
              ),
              selectedAccountEmail != null
                  ? Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: switchUserAccount,
                        tooltip: "Switch account to $selectedAccountEmail",
                        iconSize: AppThemeData.iconSizeMedium + 5.0,
                        color: Colors.lightBlue,
                        icon: Icon(Icons.switch_account_outlined),
                      ),
                    )
                  : SizedBox.shrink()
            ],
          ),
        );
      }),
    );
  }

  void switchUserAccount() {
    // Switch user account to selectedUserAccount
    UserController userController =
        Provider.of<UserController>(context, listen: false);

    userController.switchUser(context, email: selectedAccountEmail!);
  }
}
