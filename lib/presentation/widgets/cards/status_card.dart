import 'package:cointrack/core/constants/app_colors.dart';
import 'package:cointrack/core/constants/font_text.dart';
import 'package:flutter/material.dart';

class StatusCard extends StatelessWidget {
  final String title;
  final String value;

  const StatusCard({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: FontText.bodySmall,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: FontText.bodyLarge,
          ),
        ],
      ),
    );
  }
}
