import 'dart:io';

import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'package:password_manager/controllers/app_router.dart';
import 'package:password_manager/models/user.dart';

class AuthController extends ChangeNotifier {
  final Box<User> usersBox;

  List<User> get users => usersBox.toMap().values.toList();

  User? currentlyLoggedInUser;
  bool get isUserLoggedIn => currentlyLoggedInUser != null ? true : false;

  AuthController({
    required this.usersBox,
  });

  void loginUser({required String email, required String password}) {
    User? dbUser = users.firstWhereOrNull(
        (user) => user.email == email && user.password == password);

    currentlyLoggedInUser = dbUser;
    notifyListeners();
  }

  void signUpUser(User user) {
    usersBox.put(user.id, user);
    notifyListeners();
  }

  void logoutUser(BuildContext context) {
    currentlyLoggedInUser = null;
    Navigator.pushReplacementNamed(context, AppRouter.LOGIN_PAGE);
    notifyListeners();
  }

  void updateLoggedInUser(User updatedUser) {
    usersBox.put(updatedUser.id, updatedUser);
    currentlyLoggedInUser = updatedUser;
    notifyListeners();
  }
}

/// Restricts a page for viewing only by authenticate users.
void isPageAuthRestricted(BuildContext context) {
  AuthController authController =
      Provider.of<AuthController>(context, listen: false);

  if (!authController.isUserLoggedIn) {
    Navigator.pushNamed(context, AppRouter.LOGIN_PAGE);
  }
}
