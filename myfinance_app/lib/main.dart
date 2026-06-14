import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:myfinance_app/app.dart';
import 'package:myfinance_app/core/config/app_config.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await AppConfig.setup();

  runApp(const App());

  FlutterNativeSplash.remove();
}
