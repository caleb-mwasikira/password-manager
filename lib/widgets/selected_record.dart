import 'package:flutter/material.dart';

/// The [SelectedRecord] widget displays information about
/// the currently selected record.
class SelectedRecord extends StatelessWidget {
  const SelectedRecord({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 400.0,
              margin: EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                "No selected record",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
