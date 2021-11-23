import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'package:password_manager/widgets/auth_widgets/form_submit_btn.dart';
import 'package:password_manager/widgets/auth_widgets/provider_signin_btn.dart';
import 'package:password_manager/widgets/form_field_widget.dart';

class AuthForm extends StatefulWidget {
  final String title;
  final Function onComplete;

  const AuthForm({
    Key? key,
    required this.title,
    required this.onComplete,
  }) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 40.0),
                  child: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
                ProviderSignInBtn(
                  providerTitle: "${widget.title} with Google",
                  providerIcon: LineIcons.googlePlus,
                  providerColor: Color(0XFF0F9D58),
                  onBtnPressed: () {
                    print('${widget.title} with google btn was clicked');
                  },
                ),
                Container(
                  width: 320.0,
                  height: 50.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Divider(),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          "or ${widget.title} with Email",
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
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      authFormField(
                        context: context,
                        labelText: "Username",
                        formFieldWidget: FormFieldWidget(
                          name: "username",
                          hintText: "john doe",
                          prefixIcon: LineIcons.userCircle,
                          textInputType: TextInputType.text,
                          width: 200.0,
                        ),
                      ),
                      authFormField(
                        context: context,
                        labelText: "Email",
                        formFieldWidget: FormFieldWidget(
                          name: "email",
                          hintText: "mail@website.com",
                          prefixIcon: LineIcons.envelope,
                          textInputType: TextInputType.emailAddress,
                        ),
                      ),
                      authFormField(
                        context: context,
                        labelText: "Password",
                        formFieldWidget: FormFieldWidget(
                          name: "password",
                          hintText: "Min 8 characters",
                          prefixIcon: LineIcons.lock,
                          obscureText: true,
                          textInputType: TextInputType.visiblePassword,
                        ),
                      ),
                      Container(
                        width: 300.0,
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: rememberMe,
                                  onChanged: (_) {
                                    setState(() {
                                      rememberMe = !rememberMe;
                                    });
                                  },
                                ),
                                Text(
                                  "Remember me",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(color: Colors.grey),
                                )
                              ],
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
                                    .bodyText2
                                    ?.copyWith(color: Colors.lightBlueAccent),
                              ),
                            )
                          ],
                        ),
                      ),
                      FormSubmitBtn(
                        title: widget.title,
                        onComplete: widget.onComplete,
                        formKey: _formKey,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget authFormField({
    required BuildContext context,
    required String labelText,
    required FormFieldWidget formFieldWidget,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Text(
            labelText,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        formFieldWidget,
      ],
    );
  }
}
