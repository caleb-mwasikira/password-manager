import 'package:flutter/material.dart';

import 'package:password_manager/controllers/app_data.dart';
import 'package:password_manager/controllers/auth_controller.dart';
import 'package:password_manager/models/user.dart';
import 'package:password_manager/widgets/avatars/user_photo.dart';
import 'package:password_manager/themes/app_theme_data.dart';
import 'package:password_manager/widgets/gallery/gallery.dart';
import 'package:password_manager/entities/gallery_item.dart';
import 'package:provider/provider.dart';

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
        AppData.fetchAssetImages(assetDir: 'images/users');
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

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
        builder: (BuildContext context, AuthController authController, _) {
      String? userProfile = authController.currentlyLoggedInUser?.profilePic;

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
                  imgUrl: userProfile,
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
                borderRadius: AppThemeData.borderRadiusSmall,
              ),
              child: FutureBuilder(
                future: assetImages,
                builder: (BuildContext context,
                    AsyncSnapshot<List<String>> snapshot) {
                  if (snapshot.hasData) {
                    final List<String> assetImages = snapshot.data!;

                    return Gallery(
                      title: "Select Avatar",
                      name: "Avatar",
                      items: assetImages
                          .map((assetImage) =>
                              GalleryItem(name: "", imgUrl: assetImage))
                          .toList(),
                      galleryItemRadius: 40.0,
                      isAssetImages: true,
                      onSelectGalleryItem: (int index) {
                        String? selectedUserProfile = assetImages[index];

                        User? currentlyLoggedInUser =
                            authController.currentlyLoggedInUser;

                        if (currentlyLoggedInUser != null) {
                          currentlyLoggedInUser.profilePic =
                              selectedUserProfile;

                          authController
                              .updateLoggedInUser(currentlyLoggedInUser);
                        }
                      },
                    );
                  }

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            )
          ],
        ),
      );
    });
  }
}
