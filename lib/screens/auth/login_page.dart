import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'package:password_manager/widgets/auth_widgets/auth_widgets.dart';
import 'package:password_manager/widgets/auth_widgets/form_submit_btn.dart';
import 'package:password_manager/widgets/auth_widgets/provider_auth_btn.dart';
import 'package:password_manager/widgets/forms/form_field_widget.dart';
import 'package:password_manager/controllers/user_controller.dart';
import 'package:password_manager/controllers/app_router.dart';
import 'package:password_manager/entities/auth_status.dart';
import 'package:password_manager/utils/utils.dart';
import 'package:password_manager/utils/enums.dart';
import 'package:password_manager/models/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  User? selectedUserProfile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              authDisplayArt("assets/images/display_art/account.jpg"),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Form(
                  key: formKey,
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ProviderAuthBtn(
                                title: "Login with Google",
                                icon: LineIcons.googleLogo,
                                color: Color(0XFF0F9D58),
                                onPressed: () {
                                  print('Login with google btn was clicked');

                                  // TODO: Implement login with Google feature.
                                },
                              ),
                              Container(
                                width: 250.0,
                                height: 20.0,
                                margin: EdgeInsets.symmetric(vertical: 10.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Divider(),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5.0),
                                      child: Text(
                                        "or Login with Email",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.copyWith(color: Colors.grey),
                                      ),
                                    ),
                                    Expanded(
                                      child: Divider(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FormFieldWidget(
                                name: "email",
                                hintText: "mail@website.com",
                                prefixIcon: LineIcons.envelope,
                                textInputType: InputType.EMAIL,
                                onSaved: (String? value) {
                                  email = value ?? "";
                                },
                              ),
                              FormFieldWidget(
                                name: "password",
                                hintText: "Min 8 characters",
                                prefixIcon: LineIcons.lock,
                                obscureText: true,
                                textInputType: InputType.PASSWORD,
                                onSaved: (String? value) {
                                  password = value ?? "";
                                },
                              ),
                              Container(
                                width: 300.0,
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    altAuthenticationQst(
                                      title: "Dont have an account? SignUp",
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                AppRouter.SIGNUP_PAGE);
                                      },
                                      context: context,
                                    ),
                                    forgotPasswordBtn(context),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        FormSubmitBtn(
                          title: "Login",
                          formKey: formKey,
                          margin: EdgeInsets.symmetric(vertical: 10.0),
                          onSubmit: loginUser,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loginUser() {
    User user = User(
      id: Uuid().v1(),
      email: email.toLowerCase(),
      password: password,
    );

    UserController userController =
        Provider.of<UserController>(context, listen: false);

    // Login user
    AuthStatus status = userController.loginUser(user.email, user.password);

    // Navigate user to the HOME_PAGE on successful login attempt
    if (status.ok) {
      Navigator.pushReplacementNamed(context, AppRouter.HOME_PAGE);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        snackbarWidget(
          context: context,
          title: status.message,
        ),
      );
    }
  }
}
