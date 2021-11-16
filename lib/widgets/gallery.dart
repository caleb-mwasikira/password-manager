import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'package:password_manager/widgets/action_button.dart';
import 'package:password_manager/widgets/gallery_photo.dart';

class Gallery extends StatefulWidget {
  final String title;
  final String name;
  final List<Map<String, dynamic>> items;

  Gallery({
    Key? key,
    required this.title,
    required this.name,
    required this.items,
  }) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  int? selectedItemIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400.0,
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 50.0),
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          Container(
            width: 400.0,
            height: 100.0,
            margin: EdgeInsets.symmetric(horizontal: 30.0),
            child: widget.items.length > 0
                ? ListView.builder(
                    itemCount: widget.items.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      Map<String, dynamic> item = widget.items[index];

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              setState(() {
                                selectedItemIndex = index;
                              });
                            },
                            child: GalleryPhoto(
                              name: item['name'],
                              imgUrl: item['img_url'],
                              isSelected: selectedItemIndex == index,
                            ),
                          ),

                          /// If index is the last item on list, display the add photo btn
                          index == widget.items.length - 1
                              ? Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  child: addGalleryPhotoBtn(),
                                )
                              : SizedBox.shrink()
                        ],
                      );
                    },
                  )
                : Center(
                    child: addGalleryPhotoBtn(),
                  ),
          )
        ],
      ),
    );
  }

  ActionButton addGalleryPhotoBtn() {
    return ActionButton(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      radius: 35.0,
      backgroundColor: Colors.lightBlueAccent,
      child: IconButton(
        onPressed: () {
          print("add new ${widget.name} button was clicked");
        },
        tooltip: "Create New ${widget.name}",
        padding: EdgeInsets.zero,
        color: Colors.white,
        icon: Icon(LineIcons.plus),
      ),
    );
  }
}
