import 'package:flutter/material.dart';
import 'package:my_finance/core/themes/app_theme.dart';

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
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: AppTheme.borderDefault,
          gradient: LinearGradient(
            colors: [
              themeContext.colorScheme.surfaceContainer,
              themeContext.colorScheme.onPrimary,
              themeContext.colorScheme.surfaceContainer,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Padding(padding: const EdgeInsets.all(16), child: child),
      ),
    );
  }
}
