import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:password_manager/controllers/app_router.dart';
import 'package:password_manager/models/user.dart';
import 'package:password_manager/entities/auth_status.dart';
import 'package:password_manager/screens/auth/login_page.dart';

class UserController extends ChangeNotifier {
  final Box<User> usersBox;

  List<User> get users => usersBox.toMap().values.toList();

  User? currentlyLoggedInUser;
  bool get isUserLoggedIn => currentlyLoggedInUser != null ? true : false;

  UserController({
    required this.usersBox,
  });

  bool _userExists(String email) =>
      users.firstWhereOrNull((_user) => _user.email == email) != null;

  AuthStatus loginUser(String email, String password) {
    User? dbUser = users.firstWhereOrNull(
        (user) => user.email == email && user.password == password);

    if (dbUser == null) {
      return AuthStatus(
          ok: false, message: "Login failed. User does not exist");
    }

    currentlyLoggedInUser = dbUser;
    notifyListeners();
    return AuthStatus(ok: true, message: "Login successful");
  }

  AuthStatus signUpUser(User user) {
    // To avoid creating duplicate accounts,
    // we are first going to check if the user already exists.
    if (_userExists(user.email)) {
      return AuthStatus(ok: false, message: "User already exists");
    }

    usersBox.put(user.id, user);
    notifyListeners();

    return AuthStatus(ok: true, message: "User created successfully");
  }

  void logoutUser(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, AppRouter.LOGIN_PAGE, (route) => false);

    Future.delayed(Duration(milliseconds: 1000), () {
      currentlyLoggedInUser = null;
    });

    notifyListeners();
  }

  void switchUser(BuildContext context, {required String email}) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => LoginPage(email: email),
      ),
      (route) => false,
    );

    Future.delayed(Duration(milliseconds: 1000), () {
      currentlyLoggedInUser = null;
    });

    notifyListeners();
  }

  void updateLoggedInUser(User updatedUser) {
    usersBox.put(updatedUser.id, updatedUser);
    currentlyLoggedInUser = updatedUser;
    notifyListeners();
  }
}
