import 'package:flutter/material.dart';
import 'package:myfinance_app/components/app/app_scaffold.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Perfil",
      body: Center(
        child: Text("Tela de Perfil"),
      ),
    );
  }
}
