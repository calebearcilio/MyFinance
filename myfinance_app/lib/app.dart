import 'package:flutter/material.dart';
import 'package:myfinance_app/core/config/app_config.dart';
import 'package:myfinance_app/core/routes/app_route.dart';
import 'package:myfinance_app/core/themes/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Finance",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      locale: AppConfig.systemLocale,
      routes: AppRoutes.routes(),
    );
  }
}
