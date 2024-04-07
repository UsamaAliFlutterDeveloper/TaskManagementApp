import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanagerapp/api_service/api_services.dart';

import '../../const/utils/utils.dart';

class SignupController extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  SharedPreferences? _prefs;

  Future<void> initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

//..............register.............//
  Future<void> register(
      String email, String password, BuildContext context) async {
    try {
      await initializePrefs();
      await ApiServices.register(email, password);
      await _prefs!.setString('email', email);
      await _prefs!.setString('password', password);
      _isLoggedIn = true;
      Future.microtask(() => Navigator.pushNamed(context, '/LoginView'));
      notifyListeners();
    } catch (e) {
      log('Registration failed: $e');
      Utils.toastMessage('Registration failed: $e');

      rethrow;
    }
  }

//..............LogOut.............//
  Future<void> logout(BuildContext context) async {
    await initializePrefs();
    if (_prefs != null) {
      await _prefs!.remove('email');
      await _prefs!.remove('password');
    }
    _isLoggedIn = false;
    Future.microtask(() => Navigator.pushNamed(context, '/LoginView'));

    notifyListeners();
  }

  //............set loading for button.............//
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }
}
