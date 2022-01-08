import 'package:password_manager/controllers/auth_controller.dart';

class AppRouter {
  static const String HOME_PAGE = "/home";
  static const String SIGNUP_PAGE = "/signup";
  static const String LOGIN_PAGE = "/login";
  static const String DEVELOPERS_PAGE = "/developers";
  static const String SETTINGS_PAGE = "/settings";

  static String initialRoute({required AuthController authController}) {
    if (authController.users.isEmpty) {
      return AppRouter.SIGNUP_PAGE;
    } else if (!authController.isUserLoggedIn) {
      return AppRouter.LOGIN_PAGE;
    } else {
      return AppRouter.HOME_PAGE;
    }
  }
}
