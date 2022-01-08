import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:provider/provider.dart';

import 'package:password_manager/controllers/auth_controller.dart';
import 'package:password_manager/controllers/vault_records_controller.dart';
import 'package:password_manager/widgets/vault_records/selected_record.dart';
import 'package:password_manager/widgets/vault_records/vault_records.dart';
import 'package:password_manager/themes/app_theme_data.dart';
import 'package:password_manager/utils/enums.dart';
import 'package:password_manager/entities/menu_item.dart';
import 'package:password_manager/widgets/action_button.dart';
import 'package:password_manager/widgets/appbar_widget.dart';
import 'package:password_manager/widgets/drawer/drawer_widget.dart';
import 'package:password_manager/widgets/forms/auth_record_form.dart';
import 'package:password_manager/widgets/forms/file_record_form.dart';
import 'package:password_manager/widgets/menu_item_widget.dart';
import 'package:password_manager/utils/enum_extension.dart';
import 'package:password_manager/widgets/result.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<MenuItem> menuItems;
  CustomPopupMenuController popupMenuController = CustomPopupMenuController();

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      isPageAuthRestricted(context);
    });

    setState(() {
      menuItems = [
        MenuItem(title: RecordType.AUTH.value, icon: LineIcons.userCircle),
        MenuItem(title: RecordType.FILES.value, icon: LineIcons.fileAlt),
      ];
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(),
      drawer: DrawerWidget(),
      floatingActionButton: floatingActionButtonWidget(context),
      body: Consumer<VaultRecordsController>(
        builder: (
          BuildContext context,
          VaultRecordsController vaultRecordsController,
          _,
        ) {
          return Center(
            child: vaultRecordsController.records.isEmpty
                ? Result(
                    imgUrl: "assets/images/display_art/no_data_found.png",
                    message: "You have zero passwords saved",
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          VaultRecords(),
                          SelectedRecord(),
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  CustomPopupMenu floatingActionButtonWidget(BuildContext context) {
    return CustomPopupMenu(
      pressType: PressType.singleClick,
      controller: popupMenuController,
      menuBuilder: () {
        return Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: AppThemeData.borderRadiusSmall,
          ),
          child: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: menuItems
                  .map((item) => MenuItemWidget(
                        menuItem: item,
                        popupMenuController: popupMenuController,
                        borderRadius: AppThemeData.borderRadiusLarge,
                        onSelectMenuItem: (MenuItem selectedMenuItem) async {
                          RecordType recordType = RecordType.values.firstWhere(
                              (e) => e.value == selectedMenuItem.title);

                          return showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                contentPadding: EdgeInsets.all(15.0),
                                content: recordType == RecordType.AUTH
                                    ? AuthRecordForm()
                                    : FileRecordForm(),
                              );
                            },
                          );
                        },
                      ))
                  .toList(),
            ),
          ),
        );
      },
      child: ActionButton(
        radius: 40.0,
        iconData: LineIcons.plus,
        margin: EdgeInsets.symmetric(vertical: 20.0),
        color: Colors.white,
        backgroundColor: Colors.lightBlueAccent,
        onPressed: () {
          popupMenuController.showMenu();
        },
      ),
    );
  }
}
