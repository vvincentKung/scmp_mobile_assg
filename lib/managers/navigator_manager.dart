import 'package:flutter/material.dart';
import 'package:scmp_mobile_assg/widgets/home/home_page.dart';
import 'package:scmp_mobile_assg/widgets/login/login_page.dart';

class NavigatorManager {

  static final NavigatorManager _instance = NavigatorManager._internal();
  factory NavigatorManager() {
    return _instance;
  }
  NavigatorManager._internal();

  void navigateToLogin(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void navigateToHome(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
  }
}