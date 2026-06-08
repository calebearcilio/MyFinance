import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myfinance_app/core/models/finance/finance.dart';
import 'package:myfinance_app/core/services/services_locator.dart';
import 'package:myfinance_app/core/themes/app_theme.dart';
import 'package:myfinance_app/features/common/components/loading_component.dart';

class DashboardCard extends StatefulWidget {
  const DashboardCard({
    super.key,
  });

  @override
  State<DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  @override
  Widget build(BuildContext context) {
    final numberFormate = NumberFormat.simpleCurrency();
    final themeContext = Theme.of(context);

    return StreamBuilder<Finance>(
      stream: ServiceLocator.transactionRepository.wacthMonthlyFinance(),
      builder: (context, snapshot) {
        if (snapshot.hasError ||
            snapshot.connectionState == ConnectionState.waiting ||
            snapshot.data == null) {
          return SliverToBoxAdapter(
            child: Card(
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
                  child: LoadingComponent(),
                ),
              ),
            ),
          );
        }

        final finance = snapshot.data!;
        return SliverToBoxAdapter(
          child: Card(
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
                      numberFormate.format(finance.balance),
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
                                numberFormate.format(finance.income),
                                style: themeContext.textTheme.headlineSmall!
                                    .copyWith(
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
                                numberFormate.format(finance.expense),
                                style: themeContext.textTheme.headlineSmall!
                                    .copyWith(
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
          ),
        );
      },
    );
  }
}
