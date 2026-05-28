import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:myfinance_app/app_theme.dart';

class HomeChart extends StatelessWidget {
  const HomeChart({super.key});

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
              themeContext.colorScheme.tertiary,
              themeContext.colorScheme.surface,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        width: 200,
        height: 300,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: PieChart(
            PieChartData(
              sectionsSpace: 2, // Espaço entre as fatias
              centerSpaceRadius:
                  40, // Deixe em 0 para pizza inteira, ou aumente para formato de rosca
              sections: [
                PieChartSectionData(
                  color: Colors.blue,
                  value: 40,
                  title: '40%',
                  radius: 60,
                  titleStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                PieChartSectionData(
                  color: Colors.red,
                  value: 30,
                  title: '30%',
                  radius: 60,
                  titleStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                PieChartSectionData(
                  color: Colors.green,
                  value: 20,
                  title: '20%',
                  radius: 60,
                  titleStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                PieChartSectionData(
                  color: Colors.orange,
                  value: 10,
                  title: '10%',
                  radius: 60,
                  titleStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
