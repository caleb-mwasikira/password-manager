import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';

import 'package:password_manager/entities/enums.dart';
import 'package:password_manager/entities/item.dart';
import 'package:password_manager/themes/app_theme_data.dart';
import 'package:password_manager/widgets/create_new_record.dart';
import 'package:password_manager/widgets/action_button.dart';
import 'package:password_manager/widgets/appbar_widget.dart';
import 'package:password_manager/widgets/drawer/drawer_widget.dart';
import 'package:password_manager/widgets/vault_records.dart';
import 'package:password_manager/widgets/selected_record.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Item> menuItems;
  CustomPopupMenuController _controller = CustomPopupMenuController();

  @override
  void initState() {
    menuItems = [
      Item(name: RecordType.AUTH, icon: LineIcons.key),
      Item(name: RecordType.FILES, icon: LineIcons.copyAlt),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      floatingActionButton: CustomPopupMenu(
        pressType: PressType.singleClick,
        controller: _controller,
        menuBuilder: () {
          return Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: AppThemeData.borderRadius,
            ),
            child: IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: menuItems
                    .map(
                      (item) => menuItemWidget(item: item),
                    )
                    .toList(),
              ),
            ),
          );
        },
        child: ActionButton(
          radius: 35.0,
          margin: EdgeInsets.symmetric(vertical: 20.0),
          backgroundColor: Colors.lightBlueAccent,
          child: IconButton(
            onPressed: () {
              _controller.showMenu();
            },
            tooltip: "Create New Record",
            padding: EdgeInsets.zero,
            color: Colors.white,
            icon: Icon(LineIcons.plus),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            AppBarWidget(),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SelectedRecord(),
                  VaultRecords(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget menuItemWidget({required Item item}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: AppThemeData.borderRadius,
      ),
      child: InkWell(
        onTap: () async {
          print('menu item ${item.name.toString()} was clicked');
          _controller.hideMenu();

          createNewVault(context: context, recordType: item.name);
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
          child: Row(
            children: <Widget>[
              Icon(
                item.icon,
                size: AppThemeData.iconsSizeMedium,
                color: Colors.white,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    item.name.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> createNewVault(
      {required BuildContext context, required RecordType recordType}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "Create New Record",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
          content: CreateNewRecord(
            recordType: recordType,
            onComplete: () {
              print('creating a new vault account');
            },
          ),
        );
      },
    );
  }
}
