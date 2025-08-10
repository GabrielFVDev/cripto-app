import 'package:cointrack/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class PerformanceCard extends StatelessWidget {
  final String title;
  final String value;
  final bool isPositive;

  const PerformanceCard({
    super.key,
    required this.title,
    required this.value,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppColors.whiteWithOpacity80,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isPositive ? Icons.trending_up : Icons.trending_down,
                color: isPositive ? Colors.green : Colors.red,
                size: 14,
              ),
              const SizedBox(width: 2),
              Text(
                value,
                style: TextStyle(
                  color: isPositive ? Colors.green : Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
