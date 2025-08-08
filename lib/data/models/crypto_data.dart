import 'package:flutter/material.dart';

class CryptoData {
  final String name;
  final String symbol;
  final double price;
  final double change;
  final String icon;
  final Color iconColor;

  CryptoData({
    required this.name,
    required this.symbol,
    required this.price,
    required this.change,
    required this.icon,
    required this.iconColor,
  });

  bool get isPositive => change > 0;

  String get formattedPrice =>
      '\$${price < 1 ? price.toStringAsFixed(4) : price.toStringAsFixed(2)}';

  String get formattedChange =>
      '${isPositive ? '+' : ''}${change.toStringAsFixed(2)}%';
}
