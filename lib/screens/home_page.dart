import 'package:flutter/material.dart';
import 'package:password_manager/models/vault_account.dart';
import 'package:password_manager/widgets/appbar_widget.dart';

import 'package:password_manager/widgets/drawer_widget.dart';
import 'package:password_manager/widgets/vault_accounts_widget.dart';
import 'package:password_manager/widgets/vault_details.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      body: Center(
        child: Column(
          children: [
            AppBarWidget(),
            
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  VaultDetails(),
                  
                  VaultAccountsWidget(),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}
