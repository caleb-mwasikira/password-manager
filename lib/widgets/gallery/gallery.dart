import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'package:password_manager/widgets/action_button.dart';
import 'package:password_manager/widgets/gallery/circular_gallery_item.dart';
import 'package:password_manager/widgets/gallery/gallery_item.dart';
import 'package:password_manager/widgets/gallery/rect_gallery_item.dart';

class Gallery extends StatefulWidget {
  final String galleryTitle;
  final List<GalleryItem> items;

  final BoxShape shape;

  /// indicates whether the [items] list can be added onto or not
  final bool isMutable;

  Gallery({
    Key? key,
    required this.galleryTitle,
    required this.items,
    this.shape = BoxShape.circle,
    this.isMutable = true,
  }) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  int? selectedItemIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: EdgeInsets.all(10.0),
          child: Text(
            widget.galleryTitle,
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        Container(
          width: 500.0,
          height: 200.0,
          margin: EdgeInsets.symmetric(vertical: 10.0),
          child: widget.items.length > 0
              ? ListView.builder(
                  itemCount: widget.items.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    GalleryItem item = widget.items[index];

                    bool _isSelected = selectedItemIndex == index;

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
                          child: widget.shape == BoxShape.circle
                              ? CircularGalleryItem(
                                  name: item.name,
                                  imgUrl: item.imgUrl,
                                  isSelected: _isSelected,
                                )
                              : RectGalleryItem(
                                  name: item.name,
                                  imgUrl: item.imgUrl,
                                  isSelected: _isSelected,
                                  recordType: item.recordType,
                                ),
                        ),

                        /// If  [isMutable]
                        ///  display the [addGalleryItemBtn] on the last index
                        index == widget.items.length - 1 && widget.isMutable
                            ? Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                child: ActionButton(
                                  margin: EdgeInsets.symmetric(vertical: 5.0),
                                  radius: 35.0,
                                  backgroundColor: Colors.lightBlueAccent,
                                  shape: widget.shape,
                                  child: IconButton(
                                    onPressed: () {
                                      print(
                                          "add new ${widget.galleryTitle} button was clicked");
                                    },
                                    tooltip:
                                        "Create New ${widget.galleryTitle}",
                                    padding: EdgeInsets.zero,
                                    color: Colors.white,
                                    icon: Icon(LineIcons.plus),
                                  ),
                                ),
                              )
                            : SizedBox.shrink()
                      ],
                    );
                  },
                )
              : SizedBox.shrink(),
        )
      ],
    );
  }
}
