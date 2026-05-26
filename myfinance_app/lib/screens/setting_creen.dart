import 'package:flutter/material.dart';
import 'package:myfinance_app/components/app/app_scaffold.dart';

class SettingCreen extends StatelessWidget {
  const SettingCreen({super.key});

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
