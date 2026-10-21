import 'package:flutter/material.dart';
import 'package:my_finance/features/common/components/app_scaffold.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Configurações",
      body: Center(
        child: Text("Tela de Configurações"),
      ),
    );
  }
}
