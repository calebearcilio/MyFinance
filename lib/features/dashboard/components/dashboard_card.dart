import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_finance/core/models/finance/finance.dart';
import 'package:my_finance/features/common/components/app_section_card.dart';

class DashboardCard extends StatelessWidget {
  final Finance finance;

  const DashboardCard({
    super.key,
    required this.finance,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormate = NumberFormat.simpleCurrency();
    final themeContext = Theme.of(context);

    return SliverToBoxAdapter(
      child: AppSectionCard(
        child: Column(
          spacing: 10,
          children: [
            Text(
              "Saldo do mês",
              style: themeContext.textTheme.titleLarge,
            ),
            Text(
              currencyFormate.format(finance.balance),
              style: themeContext.textTheme.displaySmall!.copyWith(
                color: finance.balance.isNegative ? Colors.red : Colors.green,
              ),
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
                        currencyFormate.format(finance.income),
                        style: themeContext.textTheme.headlineSmall!.copyWith(
                          color: Colors.green,
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
                        currencyFormate.format(finance.expense),
                        style: themeContext.textTheme.headlineSmall!.copyWith(
                          color: Colors.red,
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
    );
  }
}
