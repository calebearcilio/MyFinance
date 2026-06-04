import 'package:flutter/material.dart';
import 'package:myfinance_app/presentation/components/app/app_scaffold.dart';

class BugetScreen extends StatelessWidget {
  const BugetScreen({super.key});

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
