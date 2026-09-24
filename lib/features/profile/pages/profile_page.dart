import 'package:flutter/material.dart';
import 'package:my_finance/features/common/components/app_scaffold.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
