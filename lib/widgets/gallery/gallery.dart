import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'package:password_manager/utils/utils.dart';
import 'package:password_manager/widgets/action_button.dart';
import 'package:password_manager/widgets/gallery/circular_gallery_item.dart';
import 'package:password_manager/entities/gallery_item.dart';
import 'package:password_manager/widgets/gallery/rect_gallery_item.dart';

// ignore: must_be_immutable
class Gallery extends StatefulWidget {
  final String title;
  final String? name;
  final List<GalleryItem> items;
  final void Function(int selectedIndex) onSelectGalleryItem;

  final BoxShape shape;
  final double width, height, galleryItemRadius;
  final EdgeInsets margin;

  // [isMutable] indicates whether the [items] list can be added onto or not
  final bool isMutable, isAssetImages;

  Gallery({
    Key? key,
    required this.title,
    this.name,
    required this.items,
    required this.onSelectGalleryItem,
    this.shape = BoxShape.circle,
    this.width = 400.0,
    this.height = 80.0,
    this.galleryItemRadius = 25.0,
    this.margin = EdgeInsets.zero,
    this.isMutable = true,
    this.isAssetImages = false,
  }) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  int? selectedItemIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          Container(
            height: widget.height,
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

                              widget.onSelectGalleryItem(index);
                            },
                            child: widget.shape == BoxShape.circle
                                ? CircularGalleryItem(
                                    name: item.name,
                                    imgUrl: item.imgUrl,
                                    radius: widget.galleryItemRadius,
                                    isSelected: _isSelected,
                                    isAssetImage: widget.isAssetImages,
                                  )
                                : RectGalleryItem(
                                    name: item.name,
                                    imgUrl: item.imgUrl,
                                    isSelected: _isSelected,
                                    recordType: item.recordType,
                                  ),
                          ),

                          /// If  [isMutable]
                          ///  display a [AddGalleryItemBtn] on the last index
                          index == widget.items.length - 1 && widget.isMutable
                              ? Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 20.0),
                                  child: ActionButton(
                                    margin: EdgeInsets.symmetric(vertical: 5.0),
                                    radius: 35.0,
                                    iconData: LineIcons.plus,
                                    onPressed: () async {
                                      await selectImageFromDisk(
                                          context: context);
                                    },
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
      ),
    );
  }
}
