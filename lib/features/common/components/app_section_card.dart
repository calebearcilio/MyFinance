import 'package:flutter/material.dart';
import 'package:myfinance_app/core/themes/app_theme.dart';

class AppSectionCard extends StatelessWidget {
  final Widget child;

  const AppSectionCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final themeContext = Theme.of(context);

    return Card(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: AppTheme.borderDefault,
          gradient: LinearGradient(
            colors: [
              themeContext.colorScheme.onPrimary,
              themeContext.colorScheme.surfaceContainer,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(padding: const EdgeInsets.all(16), child: child),
      ),
    );
  }
}
