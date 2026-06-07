import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:myfinance_app/app.dart';
import 'package:myfinance_app/core/services/services_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Capturar o locale atual do sistema
  final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;

  // Definir o locale padrão do Intl
  Intl.defaultLocale = systemLocale.toString();

  // Inicializar os dados de formatação
  await initializeDateFormatting(systemLocale.toString());

  // Inicializar banco de dados e repositórios
  await ServiceLocator.init();

  runApp(App(locale: systemLocale));
}
