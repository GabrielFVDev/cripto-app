class CoinEntity {
  final String id;
  final String name;
  final String symbol;
  final int rank;
  final double price;
  final double changePercent24h;

  CoinEntity({
    required this.id,
    required this.name,
    required this.symbol,
    required this.rank,
    required this.price,
    required this.changePercent24h,
  });

  bool get isPositive => changePercent24h > 0;

  String get formattedPrice =>
      '\$${price < 1 ? price.toStringAsFixed(4) : price.toStringAsFixed(2)}';

  String get formattedChange =>
      '${isPositive ? '+' : ''}${changePercent24h.toStringAsFixed(2)}%';
}
