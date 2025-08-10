import 'package:cointrack/core/constants/font_text.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class CoinTrackerAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CoinTrackerAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appBarBackground,
      title: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          title,
          style: FontText.titleLarge,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
