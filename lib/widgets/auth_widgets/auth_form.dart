import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:password_manager/controllers/app_router.dart';
import 'package:uuid/uuid.dart';

import 'package:password_manager/controllers/app_data.dart';
import 'package:password_manager/utils/enums.dart';
import 'package:password_manager/models/user.dart';
import 'package:password_manager/widgets/auth_widgets/form_submit_btn.dart';
import 'package:password_manager/widgets/auth_widgets/provider_signin_btn.dart';
import 'package:password_manager/widgets/forms/form_field_widget.dart';

class AuthForm extends StatefulWidget {
  final FormType formType;
  final Function(User userData) onComplete;

  const AuthForm({
    Key? key,
    required this.formType,
    required this.onComplete,
  }) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final formKey = GlobalKey<FormState>();

  String? username;
  String email = "";
  String password = "";

  String get title {
    switch (widget.formType) {
      case FormType.SIGNUP_FORM:
        return "SignUp";
      default:
        return "Login";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProviderSignInBtn(
                    providerTitle: "$title with Google",
                    providerIcon: LineIcons.googlePlus,
                    providerColor: Color(0XFF0F9D58),
                    onBtnPressed: () {
                      print('$title with google btn was clicked');
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
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            "or $title with Email",
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
                  widget.formType == FormType.SIGNUP_FORM
                      ? FormFieldWidget(
                          name: "username",
                          hintText: "john doe",
                          prefixIcon: LineIcons.userCircle,
                          textInputType: InputType.TEXT,
                          width: 200.0,
                          onSaved: (String? value) {
                            username = value;
                          },
                        )
                      : SizedBox.shrink(),
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
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            if (widget.formType == FormType.SIGNUP_FORM) {
                              Navigator.of(context)
                                  .pushReplacementNamed(AppRouter.LOGIN_PAGE);
                            } else {
                              Navigator.of(context)
                                  .pushReplacementNamed(AppRouter.SIGNUP_PAGE);
                            }
                          },
                          child: Text(
                            widget.formType == FormType.SIGNUP_FORM
                                ? "Login Instead"
                                : "SignUp Instead",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: Colors.lightBlueAccent),
                          ),
                        ),
                        InkWell(
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            print('forgot password btn was clicked');
                          },
                          child: Text(
                            "Forgot Password?",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: Colors.lightBlueAccent),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            FormSubmitBtn(
              title: title,
              formKey: formKey,
              margin: EdgeInsets.symmetric(vertical: 10.0),
              onSubmit: () {
                User newUser = User(
                  id: Uuid().v1(),
                  username: username?.toLowerCase(),
                  email: email.toLowerCase(),
                  password: password,
                );

                widget.onComplete(newUser);
              },
            ),
          ],
        ),
      ),
    );
  }
}
