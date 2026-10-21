import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:my_finance/app.dart';
import 'package:my_finance/core/config/app_config.dart';
import 'package:my_finance/core/database/database_config.dart';
import 'package:my_finance/core/database/sync_service.dart';
import 'package:my_finance/features/category/data/repositories/category_repository.dart';
import 'package:my_finance/features/filters/domain/providers/filter_provider.dart';
import 'package:my_finance/features/transaction/data/repositories/transaction_repository.dart';
import 'package:provider/provider.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await AppConfig.setup();

  final isar = DatabaseConfig.instance;
  final syncService = SyncService();

  runApp(
    MultiProvider(
      providers: [
        Provider<SyncService>.value(value: syncService),
        Provider<CategoryRepository>(
          create: (_) => CategoryRepository(
            db: isar,
            syncService: syncService,
          ),
        ),
        Provider<TransactionRepository>(
          create: (_) => TransactionRepository(
            db: isar,
            syncService: syncService,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => FilterProvider(),
        ),
      ],
      child: const App(),
    ),
  );

  FlutterNativeSplash.remove();
}
