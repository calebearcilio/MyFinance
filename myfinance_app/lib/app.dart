import 'package:flutter/material.dart';
import 'package:myfinance_app/app_route.dart';
import 'package:myfinance_app/app_theme.dart';

class App extends StatelessWidget {
  final Locale locale;

  const App({super.key, required this.locale});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MyFinance",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      locale: locale,
      routes: AppRoutes.routes(),
      initialRoute: AppRoutes.home,
    );
  }
}
