import 'package:flutter/material.dart';
import 'package:myfinance_app/presentation/components/app/app_scaffold.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Relatórios",
      body: Center(
        child: Text("Tela de Relatórios"),
      ),
    );
  }
}
