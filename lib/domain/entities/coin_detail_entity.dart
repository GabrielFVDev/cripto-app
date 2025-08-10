class CoinDetailEntity {
  final String id;
  final String name;
  final String symbol;
  final int rank;
  final double price;
  final double changePercent24h;
  final double marketCap;
  final double volume24h;
  final double changePercent1h;
  final double changePercent7d;
  final double changePercent30d;
  final double changePercent1y;

  const CoinDetailEntity({
    required this.id,
    required this.name,
    required this.symbol,
    required this.rank,
    required this.price,
    required this.changePercent24h,
    required this.marketCap,
    required this.volume24h,
    required this.changePercent1h,
    required this.changePercent7d,
    required this.changePercent30d,
    required this.changePercent1y,
  });

  bool get isPositive => changePercent24h > 0;
  bool get isPositive7d => changePercent7d > 0;
  bool get isPositive30d => changePercent30d > 0;
  bool get isPositive1y => changePercent1y > 0;

  String get formattedPrice =>
      '\$${price < 1 ? price.toStringAsFixed(4) : price.toStringAsFixed(2)}';

  String get formattedChange =>
      '${isPositive ? '+' : ''}${changePercent24h.toStringAsFixed(2)}%';

  String get formattedChange7d =>
      '${isPositive7d ? '+' : ''}${changePercent7d.toStringAsFixed(2)}%';

  String get formattedChange30d =>
      '${isPositive30d ? '+' : ''}${changePercent30d.toStringAsFixed(2)}%';

  String get formattedChange1y =>
      '${isPositive1y ? '+' : ''}${changePercent1y.toStringAsFixed(2)}%';
}
