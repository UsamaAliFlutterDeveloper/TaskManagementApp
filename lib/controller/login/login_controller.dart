import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_service/api_services.dart';
import '../../const/utils/utils.dart';

class LoginController extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late SharedPreferences _prefs;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _isLoggedIn = _prefs.containsKey('email') && _prefs.containsKey('password');
    notifyListeners();
  }

  Future<void> login(
      String email, String password, BuildContext context) async {
    try {
      await initSharedPreferences();

      await ApiServices.login(email, password);
      await _prefs.setString('email', email);
      await _prefs.setString('password', password);
      _isLoggedIn = true;
      Utils.toastMessage('successfully login');
      Future.microtask(() => Navigator.pushNamed(context, '/HomeView'));

      notifyListeners();
    } catch (e) {
      log('Login failed: $e');
      Utils.toastMessage('Login failed: $e');
      rethrow;
    }
  }

//.................loginbuttonloading.................//
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }
}
