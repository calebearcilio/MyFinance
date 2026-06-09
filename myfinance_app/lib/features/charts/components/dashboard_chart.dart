import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:myfinance_app/core/themes/app_theme.dart';
import 'package:myfinance_app/core/models/category/category_summary.dart';

class DashboardChart extends StatelessWidget {
  final List<CategorySummary> data;

  const DashboardChart({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final themeContext = Theme.of(context);
    final total = data.fold<double>(
      0,
      (sum, item) => sum + item.total,
    );

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
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Gráfico
                SizedBox(
                  width: 280,
                  height: 280,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius: 40,
                      sections: data.map((item) {
                        final percentage = (item.total / total) * 100;
                        return PieChartSectionData(
                          color: item.color,
                          value: item.total,
                          title: "${percentage.toStringAsFixed(0)}%",
                          radius: 60,
                          titleStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Legenda
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: data.map((item) {
                    final percentage = (item.total / total) * 100;
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Cor da categoria
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: item.color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        // Nome da categoria
                        Flexible(
                          child: Text(
                            "${item.categoryName} (${percentage.toStringAsFixed(1)}%)",
                            style: themeContext.textTheme.labelSmall?.copyWith(
                              color: themeContext.textTheme.labelSmall?.color,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
