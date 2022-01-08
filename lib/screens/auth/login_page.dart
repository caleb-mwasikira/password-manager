import 'package:flutter/material.dart';
import 'package:password_manager/controllers/app_data.dart';
import 'package:password_manager/controllers/auth_controller.dart';
import 'package:password_manager/controllers/app_router.dart';
import 'package:password_manager/utils/enums.dart';
import 'package:password_manager/models/user.dart';

import 'package:password_manager/widgets/auth_widgets/auth_form.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Tooltip(
                  message: "",
                  child: Image.asset(
                    "assets/images/display_art/woman_studying_in_armchair.png",
                    height: 350.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Consumer<AuthController>(
                builder:
                    (BuildContext context, AuthController authController, _) {
                  return Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: AuthForm(
                      formType: FormType.LOGIN_FORM,
                      onComplete: (User user) {
                        // Login user
                        authController.loginUser(
                            email: user.email, password: user.password);

                        if (authController.isUserLoggedIn) {
                          Navigator.pushReplacementNamed(
                              context, AppRouter.HOME_PAGE);
                        } else {
                          print("Failed login attempt");
                        }
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
