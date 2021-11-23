import 'package:flutter/material.dart';

import 'package:password_manager/data/app_data.dart';
import 'package:password_manager/entities/auth_record.dart';
import 'package:password_manager/entities/enums.dart';
import 'package:password_manager/entities/file_record.dart';
import 'package:password_manager/utils/utils.dart';
import 'package:password_manager/widgets/gallery/gallery.dart';
import 'package:password_manager/widgets/gallery/gallery_item.dart';

class RecentRecords extends StatefulWidget {
  const RecentRecords({Key? key}) : super(key: key);

  @override
  _RecentRecordsState createState() => _RecentRecordsState();
}

class _RecentRecordsState extends State<RecentRecords> {
  Future<List>? recentRecords;

  @override
  void initState() {
    Future<List> _recentRecords =
        AppData.fetchAssetData(dataDir: 'assets/data/records.json', limit: 5);
    setState(() {
      recentRecords = _recentRecords;
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
              : Container(
                  padding: EdgeInsets.all(20.0),
                  child: Gallery(
                    galleryTitle: "Recently Viewed",
                    shape: BoxShape.rectangle,
                    isMutable: false,
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
                            imgUrl: null,
                            recordType: RecordType.FILES,
                          );
                        }
                      },
                    ).toList(),
                  ),
                );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
