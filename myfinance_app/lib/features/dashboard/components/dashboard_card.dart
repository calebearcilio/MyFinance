import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myfinance_app/core/themes/app_theme.dart';

class DashboardCard extends StatelessWidget {
  final double value;
  final double revenue;
  final double expense;
  const DashboardCard({
    super.key,
    required this.value,
    required this.revenue,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    final numberFormate = NumberFormat.simpleCurrency();
    final themeContext = Theme.of(context);

    return Card(
      color: Colors.transparent,

      child: Container(
        decoration: BoxDecoration(
          borderRadius: AppTheme.borderDefault,
          gradient: LinearGradient(
            colors: [
              themeContext.colorScheme.tertiary,
              themeContext.colorScheme.surface,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            spacing: 10,
            children: [
              Text(
                "Saldo do mês",
                style: themeContext.textTheme.titleLarge,
              ),
              Text(
                numberFormate.format(value),
                style: themeContext.textTheme.displaySmall,
              ),

              SizedBox(height: 10),

              Row(
                mainAxisAlignment: .spaceEvenly,
                spacing: 20,
                children: [
                  Column(
                    children: [
                      Text(
                        "Receita",
                        style: themeContext.textTheme.labelMedium,
                      ),
                      FittedBox(
                        child: Text(
                          numberFormate.format(revenue),
                          style: themeContext.textTheme.headlineSmall!.copyWith(
                            color: themeContext.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Despesa",
                        style: themeContext.textTheme.labelMedium,
                      ),
                      FittedBox(
                        child: Text(
                          numberFormate.format(expense),
                          style: themeContext.textTheme.headlineSmall!.copyWith(
                            color: themeContext.colorScheme.error,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}