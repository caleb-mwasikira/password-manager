import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';

import 'package:password_manager/data/app_data.dart';
import 'package:password_manager/entities/enums.dart';
import 'package:password_manager/entities/menu_item.dart';
import 'package:password_manager/themes/app_theme_data.dart';
import 'package:password_manager/widgets/create_new_record.dart';
import 'package:password_manager/widgets/action_button.dart';
import 'package:password_manager/widgets/appbar_widget.dart';
import 'package:password_manager/widgets/drawer/drawer_widget.dart';
import 'package:password_manager/widgets/vault_records.dart';
import 'package:password_manager/widgets/selected_record.dart';
import 'package:password_manager/utils/enum_extension.dart';

class HomePage extends StatefulWidget {
  final String title = AppData.appName;

  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<MenuItem> menuItems;
  CustomPopupMenuController _controller = CustomPopupMenuController();

  @override
  void initState() {
    menuItems = [
      MenuItem(title: RecordType.AUTH.value, icon: LineIcons.userCircle),
      MenuItem(title: RecordType.FILES.value, icon: LineIcons.fileAlt),
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
                      (item) => menuItemWidget(menuItem: item),
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
                  VaultRecords(),
                  SelectedRecord(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget menuItemWidget({required MenuItem menuItem}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.all(Radius.circular(100.0)),
      ),
      child: InkWell(
        onTap: () async {
          print('menu item ${menuItem.title} was clicked');
          _controller.hideMenu();

          return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: CreateNewRecord(
                  recordType: RecordType.values
                      .firstWhere((e) => e.value == menuItem.title),
                  onComplete: () {
                    print('creating a new vault account');
                  },
                ),
              );
            },
          );
        },
        child: Container(
          width: 100.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(
                menuItem.icon,
                size: AppThemeData.iconsSizeMedium,
                color: Colors.white,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  menuItem.title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
