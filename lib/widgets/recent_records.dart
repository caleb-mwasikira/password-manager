import 'package:flutter/material.dart';

import 'package:password_manager/controllers/app_data.dart';
import 'package:password_manager/models/auth_record.dart';
import 'package:password_manager/utils/enums.dart';
import 'package:password_manager/models/file_record.dart';
import 'package:password_manager/widgets/gallery/gallery.dart';
import 'package:password_manager/entities/gallery_item.dart';

class RecentRecords extends StatefulWidget {
  const RecentRecords({Key? key}) : super(key: key);

  @override
  _RecentRecordsState createState() => _RecentRecordsState();
}

class _RecentRecordsState extends State<RecentRecords> {
  Future<List>? recentRecords;

  @override
  void initState() {
    setState(() {
      recentRecords =
          AppData.fetchAssetData(dataDir: 'assets/data/records.json', limit: 5);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: recentRecords,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          List _recentRecords = snapshot.data!;

          return _recentRecords.isEmpty
              ? Center(
                  child: Container(
                    width: 400.0,
                    height: 400.0,
                    child: Column(
                      children: [
                        Image.asset("assets/images/icons/no_data_found.png"),
                        Container(
                          child: Text(
                            "You have zero records saved",
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Gallery(
                  title: "Recently Viewed",
                  name: "Recently Viewed",
                  shape: BoxShape.rectangle,
                  isMutable: false,
                  height: 200.0,
                  items: _recentRecords.map(
                    (_recentRecord) {
                      if (_recentRecord['record_type'] == "AUTH") {
                        AuthRecord authRecord =
                            AuthRecord.fromJson(_recentRecord);

                        return GalleryItem(
                          name: authRecord.websiteUrl.split('/').last,
                          imgUrl: authRecord.websiteUrl,
                          recordType: RecordType.AUTH,
                        );
                      } else {
                        FileRecord fileRecord =
                            FileRecord.fromJson(_recentRecord);

                        return GalleryItem(
                          name: fileRecord.fileName,
                          imgUrl: "",
                          recordType: RecordType.FILES,
                        );
                      }
                    },
                  ).toList(),
                  onSelectGalleryItem: (int selectedIndex) {
                    print(
                        "Selected RecentlyViewed item at index $selectedIndex");
                  },
                );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
