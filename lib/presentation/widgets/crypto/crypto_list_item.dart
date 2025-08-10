import 'package:cointrack/core/constants/font_text.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/crypto_data.dart';

class CryptoListItem extends StatelessWidget {
  final CryptoData crypto;
  final VoidCallback? onTap;

  const CryptoListItem({
    super.key,
    required this.crypto,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackWithOpacity20,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Ícone da criptomoeda
                _buildCryptoIcon(),

                const SizedBox(width: 16),

                // Nome e símbolo
                _buildCryptoInfo(),

                // Preço e variação
                _buildPriceInfo(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCryptoIcon() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: crypto.iconColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          crypto.icon,
          style: FontText.titleMedium.copyWith(
            color: crypto.iconColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildCryptoInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            crypto.name,
            style: FontText.titleSmall,
          ),
          const SizedBox(height: 4),
          Text(
            crypto.symbol,
            style: FontText.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildPriceInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          crypto.formattedPrice,
          style: FontText.bodyLarge,
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              crypto.isPositive ? Icons.trending_up : Icons.trending_down,
              color: crypto.isPositive ? Colors.green : Colors.red,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              crypto.formattedChange,
              style: TextStyle(
                color: crypto.isPositive ? Colors.green : Colors.red,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
