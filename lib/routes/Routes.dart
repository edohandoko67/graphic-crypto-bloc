import 'package:crypto_fake/view/Fragment/Home.dart';
import 'package:crypto_fake/view/login/LoginPage.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String login = '/';
  static const String home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeApp());
      case login:
      default:
        return MaterialPageRoute(builder: (_) => const LoginPage());
    }
  }

  static Map<String, WidgetBuilder> get routes {
    return {
      login: (context) => const LoginPage(),
      home: (context) => const HomeApp(),
    };
  }
}