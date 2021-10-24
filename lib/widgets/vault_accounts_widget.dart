import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:password_manager/models/vault_account.dart';
import 'package:password_manager/widgets/vault_account_widget.dart';


/// The [VaultAccountsWidget] displays the passwords stored by the currently logged in
/// user account.
class VaultAccountsWidget extends StatefulWidget {
  const VaultAccountsWidget({
    Key? key,
  }) : super(key: key);

  @override
  _VaultAccountsWidgetState createState() => _VaultAccountsWidgetState();
}

class _VaultAccountsWidgetState extends State<VaultAccountsWidget> {
  late Future<List<VaultAccount>> _vaultAccounts;

  @override
  void initState() {
    super.initState();

    _vaultAccounts = readJson('assets/mock_data/vault_accounts_mock_data.json');
  }

   // Fetch VaultAccountsWidget accounts from the json file
  Future<List<VaultAccount>> readJson(String filename) async {
    final String response = await rootBundle.loadString(filename);
    final List data = await jsonDecode(response);

    List<VaultAccount> vaultAccounts = data.map((dataItem) => VaultAccount.fromJson(dataItem)).toList();
    return vaultAccounts;
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: FutureBuilder<List<VaultAccount>>(
                    future: _vaultAccounts,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<VaultAccount> vaultAccounts = snapshot.data!;

                        return ListView.builder(
                                  itemCount: vaultAccounts.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return VaultAccountWidget(
                                      vaultAccount: vaultAccounts[index]
                                    );
                                });
                                
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      // By default, show a loading spinner.
                      return const CircularProgressIndicator();
                    },
                  ),
      ),
    );
  }
}
