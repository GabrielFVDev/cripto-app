class CoinModel {
  final String name;
  final String symbol;
  final double price;
  final String id;

  CoinModel({
    required this.name,
    required this.symbol,
    required this.price,
    required this.id,
  });

  factory CoinModel.fromJson(Map<String, dynamic> json) {
    return CoinModel(
      name: json['name'],
      symbol: json['symbol'],
      price: json['price'],
      id: json['id'],
    );
  }
}
