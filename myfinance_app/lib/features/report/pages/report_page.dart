import 'package:flutter/material.dart';
import 'package:myfinance_app/features/common/components/app_scaffold.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

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
