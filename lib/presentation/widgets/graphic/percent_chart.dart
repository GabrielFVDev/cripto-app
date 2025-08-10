import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PercentChart extends StatelessWidget {
  final double percentage;
  final List<FlSpot> spots;
  const PercentChart({
    super.key,
    required this.percentage,
    required this.spots,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = percentage > 0;
    final color = isPositive ? Colors.green : Colors.red;

    return Column(
      children: [
        // Indicator row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isPositive ? Icons.trending_up : Icons.trending_down,
              color: color,
              size: 18,
            ),
            const SizedBox(width: 6),
            Text(
              '${isPositive ? '+' : ''}${percentage.toStringAsFixed(2)}%',
              style: TextStyle(
                color: color,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Chart
        Expanded(
          child: LineChart(
            LineChartData(
              titlesData: FlTitlesData(show: false),
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  color: color,
                  barWidth: 2,
                  dotData: const FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    color: color.withValues(alpha: 0.2),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
