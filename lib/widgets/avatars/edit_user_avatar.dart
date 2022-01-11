import 'package:flutter/material.dart';

import 'package:password_manager/controllers/app_data.dart';
import 'package:password_manager/controllers/user_controller.dart';
import 'package:password_manager/models/user.dart';
import 'package:password_manager/widgets/avatars/user_avatar.dart';
import 'package:password_manager/themes/app_theme_data.dart';
import 'package:password_manager/widgets/gallery/gallery.dart';
import 'package:password_manager/entities/gallery_item.dart';
import 'package:provider/provider.dart';

class EditUserAvatar extends StatefulWidget {
  const EditUserAvatar({
    Key? key,
  }) : super(key: key);

  @override
  _EditUserAvatarState createState() => _EditUserAvatarState();
}

class _EditUserAvatarState extends State<EditUserAvatar> {
  Future<List<String>>? assetImages;

  @override
  void initState() {
    Future<List<String>> _assetImages =
        AppData.fetchAssetImages(assetDir: 'images/avatars');
    setState(() {
      assetImages = _assetImages;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
        builder: (BuildContext context, UserController userController, _) {
      String? userProfile = userController.currentlyLoggedInUser?.profilePic;

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
                  ),
                ),
                clipBehavior: Clip.hardEdge,
                child: UserAvatar(
                  imgUrl: userProfile,
                  radius: 40.0,
                  isEditable: false,
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
                            userController.currentlyLoggedInUser;

                        if (currentlyLoggedInUser != null) {
                          currentlyLoggedInUser.profilePic =
                              selectedUserProfile;

                          userController
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
