import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:myfinance_app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Capturar o locale atual do sistema
  final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;

  // Definir o locale padrão do Intl
  Intl.defaultLocale = systemLocale.toString();

  // Inicialliza os dados de formatação
  await initializeDateFormatting(systemLocale.toString());
  runApp(App(locale: systemLocale));
}
