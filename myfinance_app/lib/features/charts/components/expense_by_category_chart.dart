import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:myfinance_app/core/models/category/category_summary.dart';
import 'package:myfinance_app/features/common/components/app_section_card.dart';

class ExpenseByCategoryChart extends StatelessWidget {
  final List<CategorySummary> summary;

  const ExpenseByCategoryChart({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    final themeContext = Theme.of(context);
    final total = summary.fold<double>(
      0,
      (sum, item) => sum + item.total,
    );

    return SliverToBoxAdapter(
      child: AppSectionCard(
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
                  sections: summary.map((item) {
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
              children: summary.map((item) {
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
    );
  }
}
