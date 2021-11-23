import 'package:flutter/material.dart';
import 'package:password_manager/widgets/auth_widgets/auth_form.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
                  message: "African Vectors By Vecteezy",
                  child: Image.asset(
                    "assets/images/display_art/man_playing_djembe_african_music.png",
                    height: 400.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: AuthForm(
                  title: "SignUp",
                  onComplete: () {
                    print('[SignUpForm] submitted successfully');
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
