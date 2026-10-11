import 'package:flutter/material.dart';
import 'package:my_finance/presentation/auth/components/auth_form.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: .center,
          mainAxisAlignment: .center,
          children: [
            Image.asset("assets/img/title_login_screen.png"),
            AuthForm(),
          ],
        ),
      ),
    );
  }
}
