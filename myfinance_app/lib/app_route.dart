import 'package:flutter/material.dart';
import 'package:myfinance_app/presentation/screens/main/tab_navigation_screen.dart';
import 'package:myfinance_app/presentation/screens/profile_screen.dart';

abstract class AppRoutes {
  static const String home = "/";
  static const String profile = "/profile";

  static Map<String, WidgetBuilder> routes() => {
    home: (ctx) => TabNavigationScreen(),
    profile: (ctx) => ProfileScreen(),
  };
}