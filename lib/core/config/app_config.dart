import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:myfinance_app/core/services/services_locator.dart';

/// Configuração geral da aplicação
abstract final class AppConfig {
  static late Locale? _systemLocale;

  /// Obtém o locale do sistema
  static Locale get systemLocale {
    if (_systemLocale == null) {
      throw StateError(
        'AppConfig.setup() deve ser executado antes do acesso ao systemLocale.',
      );
    }
    return _systemLocale!;
  }

  /// Inicializa todas as dependências da aplicação
  static Future<void> setup() async {
    // Inicializar banco de dados e repositórios
    await ServiceLocator.init();

    // Capturar o locale atual do sistema
    _systemLocale = WidgetsBinding.instance.platformDispatcher.locale;

    // Definir o locale padrão do Intl
    Intl.defaultLocale = _systemLocale.toString();

    // Inicializar os dados de formatação
    await initializeDateFormatting(_systemLocale.toString());
  }
}
