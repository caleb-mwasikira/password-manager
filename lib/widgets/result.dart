import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final String imgUrl;
  final String message;

  const Result({
    Key? key,
    required this.imgUrl,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 400.0,
        height: 400.0,
        child: Column(
          children: [
            Image.asset(imgUrl),
            Container(
              child: Text(
                message,
                style: Theme.of(context).textTheme.headline3,
              ),
            )
          ],
        ),
      ),
    );
  }
}
