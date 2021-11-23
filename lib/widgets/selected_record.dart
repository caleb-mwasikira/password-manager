import 'package:flutter/material.dart';

import 'package:password_manager/widgets/recent_records.dart';

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
            RecentRecords(),
          ],
        ),
      ),
    );
  }
}
