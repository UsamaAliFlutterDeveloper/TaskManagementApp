import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends ChangeNotifier {
  void navigateToView(BuildContext context) async {
    // Delay navigation to the next screen after 3 seconds
    await Future.delayed(const Duration(seconds: 3));

    // Check if the user is logged in
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn =
        prefs.containsKey('email') && prefs.containsKey('password');

    if (isLoggedIn) {
      // User is already logged in, navigate to the main view
      Future.microtask(
          () => Navigator.pushReplacementNamed(context, "/HomeView"));
    } else {
      // User is not logged in, navigate to the sign-in view
      Future.microtask(
          () => Navigator.pushReplacementNamed(context, "/LoginView"));
    }
  }
}
