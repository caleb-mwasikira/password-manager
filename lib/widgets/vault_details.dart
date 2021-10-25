import 'package:flutter/material.dart';
import 'package:password_manager/themes/custom_colors.dart';


/// The [VaultDetails] displays specific info about a selected vault.
class VaultDetails extends StatelessWidget {
  const VaultDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              width: 300.0,
              height: 200.0,
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Rose Poole",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: CustomColors.backgroundColorWhite,
                    ),
                  ),
                  Text(
                    "rosepoole@gmail.com",
                    style: TextStyle(color: CustomColors.backgroundColorWhite),
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
