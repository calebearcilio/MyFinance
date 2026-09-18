import 'package:flutter/material.dart';
import 'package:myfinance_app/features/common/components/app_scaffold.dart';

class BugetPage extends StatelessWidget {
  const BugetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Orçamentos",
      body: Center(
        child: Text("Tela de Orçamentos"),
      ),
    );
  }
}
