import 'package:cointrack/core/constants/font_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/format_numbers.dart';

class PercentChart extends StatelessWidget {
  // Custom formatter usando a formatação padrão da aplicação
  String _formatShortNumber(double value) {
    if (value >= 1e12) {
      return '${formatNumberWithDots(value / 1e12, decimals: 2)}T';
    } else if (value >= 1e9) {
      return '${formatNumberWithDots(value / 1e9, decimals: 2)}B';
    } else if (value >= 1e6) {
      return '${formatNumberWithDots(value / 1e6, decimals: 2)}M';
    } else if (value >= 1e3) {
      return '${formatNumberWithDots(value / 1e3, decimals: 2)}K';
    } else {
      return formatNumberWithDots(value, decimals: 2);
    }
  }

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
    final gradientColors = isPositive
        ? [Colors.cyanAccent, Colors.greenAccent]
        : [Colors.redAccent, Colors.orangeAccent];

    // Normalize Y values: keep only two digits after the decimal
    final normalizedSpots = spots
        .map((spot) => FlSpot(spot.x, double.parse(spot.y.toStringAsFixed(2))))
        .toList();

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
              style: FontText.labelMedium.copyWith(
                color: color,
                fontSize: 14,
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
                  spots: normalizedSpots,
                  isCurved: true,
                  gradient: LinearGradient(
                    colors: gradientColors,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  barWidth: 3,
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, bar, index) {
                      return FlDotCirclePainter(
                        radius: 4,
                        color: gradientColors.first,
                        strokeWidth: 1,
                        strokeColor: Colors.white,
                      );
                    },
                  ),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: gradientColors
                          .map((c) => c.withValues(alpha: 0.2))
                          .toList(),
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
              ],
              // Format tooltip values
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipItems: (touchedSpots) {
                    return touchedSpots.map((touchedSpot) {
                      final value = touchedSpot.y;
                      return LineTooltipItem(
                        _formatShortNumber(value),
                        const TextStyle(
                          color: Colors.cyanAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }).toList();
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
