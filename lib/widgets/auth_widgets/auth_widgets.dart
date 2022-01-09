import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

Widget authDisplayArt(String imgUri) {
  return Align(
    alignment: Alignment.centerRight,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 50.0),
      child: Tooltip(
        message: "https://www.freepik.com",
        child: Image.asset(
          imgUri,
          height: 350.0,
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}

Widget altAuthenticationQst({
  required BuildContext context,
  required String title,
  required void Function() onPressed,
}) {
  List _splitTitle = title.split("?");

  return Container(
    margin: EdgeInsets.symmetric(vertical: 10.0),
    child: RichText(
      text: TextSpan(
        text: "${_splitTitle.first}?",
        style: Theme.of(context).textTheme.bodyText1,
        children: <TextSpan>[
          TextSpan(
            text: _splitTitle.last,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(color: Colors.lightBlue),
            recognizer: TapGestureRecognizer()..onTap = onPressed,
          )
        ],
      ),
    ),
  );
}

Widget forgotPasswordBtn(BuildContext context) => Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: InkWell(
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          print('Forgot password btn was clicked');
          // Navigate to forgot password page
        },
        child: Text(
          "Forgot Password?",
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: Colors.lightBlueAccent),
        ),
      ),
    );
