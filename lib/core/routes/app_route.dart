import 'package:flutter/material.dart';
import 'package:my_finance/features/common/pages/tab_navigation_page.dart';
import 'package:my_finance/features/profile/pages/profile_page.dart';

abstract final class AppRoutes {
  static const String home = "/";
  static const String profile = "/profile";

  static Map<String, WidgetBuilder> routes() => {
    home: (ctx) => TabNavigationPage(),
    profile: (ctx) => ProfilePage(),
  };
}
