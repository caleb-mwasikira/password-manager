import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'package:password_manager/widgets/auth_widgets/auth_widgets.dart';
import 'package:password_manager/widgets/auth_widgets/form_submit_btn.dart';
import 'package:password_manager/widgets/auth_widgets/provider_auth_btn.dart';
import 'package:password_manager/widgets/forms/form_field_widget.dart';
import 'package:password_manager/widgets/common_widgets.dart';
import 'package:password_manager/controllers/user_controller.dart';
import 'package:password_manager/controllers/app_router.dart';
import 'package:password_manager/entities/auth_status.dart';
import 'package:password_manager/models/user.dart';
import 'package:password_manager/utils/enums.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    Key? key,
  }) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();

  String? username;
  String email = "";
  String password = "";

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
                                title: "SignUp with Google",
                                imgUrl: "assets/images/icons/google_icon.png",
                                onPressed: () {
                                  print('SignUp with Google btn was clicked');

                                  // TODO: Imlement registration with Google feature.
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
                                        "or SignUp with Email",
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
                                name: "Username",
                                hintText: "john doe",
                                prefixIcon: LineIcons.userCircle,
                                textInputType: InputType.TEXT,
                                width: 200.0,
                                onSaved: (String? value) {
                                  username = value;
                                },
                              ),
                              FormFieldWidget(
                                name: "Email",
                                hintText: "mail@website.com",
                                prefixIcon: LineIcons.envelope,
                                textInputType: InputType.EMAIL,
                                onSaved: (String? value) {
                                  email = value ?? "";
                                },
                              ),
                              FormFieldWidget(
                                name: "Password",
                                hintText: "Min 8 characters",
                                prefixIcon: LineIcons.lock,
                                obscureText: true,
                                textInputType: InputType.PASSWORD,
                                onSaved: (String? value) {
                                  password = value ?? "";
                                },
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10.0),
                                child: altAuthenticationQst(
                                  title: "Already have an account? Login",
                                  onPressed: () {
                                    Navigator.of(context).pushReplacementNamed(
                                        AppRouter.LOGIN_PAGE);
                                  },
                                  context: context,
                                ),
                              ),
                            ],
                          ),
                        ),
                        FormSubmitBtn(
                          title: "SignUp",
                          formKey: formKey,
                          margin: EdgeInsets.symmetric(vertical: 10.0),
                          onSubmit: signUpUser,
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

  void signUpUser() {
    User user = User(
      id: Uuid().v1(),
      username: username?.toLowerCase(),
      email: email.toLowerCase(),
      password: password,
    );

    UserController userController =
        Provider.of<UserController>(context, listen: false);

    // SignUp user
    AuthStatus status = userController.signUpUser(user);

    // Navigate user to the LOGIN_PAGE on successful signup attempt
    if (status.ok) {
      Navigator.pushReplacementNamed(context, AppRouter.LOGIN_PAGE);
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
