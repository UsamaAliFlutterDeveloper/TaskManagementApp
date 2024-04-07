import 'package:flutter/material.dart';
import 'package:taskmanagerapp/view/home/home_view.dart';
import 'package:taskmanagerapp/view/login/login_view.dart';
import 'package:taskmanagerapp/view/user/users_view.dart';
import '../view/signup/signup_view.dart';
import '../view/splash/splash_view.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (context) => const SplashView());
      case "/RegisterView":
        return MaterialPageRoute(builder: (context) => const RegisterView());
      case "/LoginView":
        return MaterialPageRoute(builder: (context) => const LoginView());
      case "/HomeView":
        return MaterialPageRoute(builder: (context) => const HomeView());
      case "/UserView":
        return MaterialPageRoute(builder: (context) => const UserView());
    }
    return null;
  }
}
