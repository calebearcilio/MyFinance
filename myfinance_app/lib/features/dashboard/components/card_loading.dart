import 'package:flutter/material.dart';
import 'package:myfinance_app/core/themes/app_theme.dart';
import 'package:myfinance_app/features/common/components/loading_component.dart';

class CardLoading extends StatelessWidget {
  const CardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      color: Colors.transparent,

      child: Container(
        decoration: BoxDecoration(
          borderRadius: AppTheme.borderDefault,
          gradient: LinearGradient(
            colors: [
              colorScheme.tertiary,
              colorScheme.surface,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: LoadingComponent(),
        ),
      ),
    );
  }
}
