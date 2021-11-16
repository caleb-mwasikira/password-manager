import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:line_icons/line_icons.dart';

import 'package:password_manager/data/app_data.dart';
import 'package:password_manager/entities/user.dart';
import 'package:password_manager/widgets/action_button.dart';
import 'package:password_manager/widgets/user_photo.dart';
import 'package:password_manager/themes/app_theme_data.dart';

class EditUserPhoto extends StatefulWidget {
  const EditUserPhoto({
    Key? key,
  }) : super(key: key);

  @override
  _EditUserPhotoState createState() => _EditUserPhotoState();
}

class _EditUserPhotoState extends State<EditUserPhoto>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  Future<List<String>>? assetImages;

  String? selectedUserProfile;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.repeat(reverse: true);
    _animation = Tween(begin: 2.0, end: 15.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });

    Future<List<String>> _assetImages =
        AppData.fetchAssetImages('images/users');
    setState(() {
      assetImages = _assetImages;
    });

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// Lets the user select an image from their device.
  void selectImageFromDisk() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );

    String? selectedFile = result?.files.single.path;

    if (selectedFile != null) {
      print('selected files -> $selectedFile');
    } else {
      final snackBar = SnackBar(
        backgroundColor: AppThemeData.primaryColor,
        content: Container(
          height: 20.0,
          child: Center(
            child: Text(
              "File Selection Cancelled By User",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.transparent,
                  width: _animation.value,
                ),
              ),
              clipBehavior: Clip.hardEdge,
              child: UserPhoto(
                imgUrl: selectedUserProfile,
                radius: 40.0,
                isEditable: false,
                foregroundColor: Colors.white,
              ),
            ),
          ),
          Container(
            width: 300.0,
            height: 150.0,
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: AppThemeData.borderRadius,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                  child: Text(
                    "Select Avatar",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
                FutureBuilder(
                    future: assetImages,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<String>> snapshot) {
                      if (snapshot.hasData) {
                        final List<String> assetImages = snapshot.data!;

                        return Container(
                          height: 50.0,
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          child: ListView.builder(
                            itemCount: assetImages.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              String assetImage = assetImages[index];

                              if (index == assetImages.length - 1) {
                                return Row(
                                  children: [
                                    displayUserPhoto(
                                      imgUrl: assetImage,
                                    ),
                                    Center(
                                      child: ActionButton(
                                        radius: 50.0,
                                        margin: EdgeInsets.all(10.0),
                                        child: IconButton(
                                          onPressed: () {
                                            selectImageFromDisk();
                                          },
                                          padding: EdgeInsets.zero,
                                          iconSize:
                                              AppThemeData.iconsSizeMedium,
                                          icon: Icon(
                                            LineIcons.plus,
                                            color: AppThemeData.primaryColor,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              }

                              return displayUserPhoto(
                                imgUrl: assetImage,
                              );
                            },
                          ),
                        );
                      }

                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget displayUserPhoto({
    String? imgUrl,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: InkWell(
        onTap: () {
          print('selected user photo $imgUrl');
          setState(() {
            selectedUserProfile = imgUrl;
          });
        },
        child: UserPhoto(
          imgUrl: imgUrl,
          radius: 20.0,
          isEditable: false,
        ),
      ),
    );
  }
}
