import 'package:flutter/material.dart';
import 'package:password_manager/widgets/auth_widgets/auth_form.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
                  message:
                      "Background vector created by macrovector - www.freepik.com",
                  child: Image.asset(
                    "assets/images/display_art/africa_round_the_world.png",
                    height: 500.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: AuthForm(
                  title: "SignIn",
                  onComplete: () {
                    print('[SignInForm] submitted successfully');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
