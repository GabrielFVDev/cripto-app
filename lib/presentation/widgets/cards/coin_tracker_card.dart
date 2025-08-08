import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class CoinTrackerCard extends StatelessWidget {
  final String title;
  final String description;
  final double height;
  final double width;

  const CoinTrackerCard({
    super.key,
    required this.title,
    required this.description,
    this.height = double.maxFinite,
    this.width = double.maxFinite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      constraints: const BoxConstraints(
        minHeight: 120,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackWithOpacity20,
            blurRadius: 8.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: Text(
                  description,
                  maxLines: 3,
                  style: const TextStyle(
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
