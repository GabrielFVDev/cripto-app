import 'package:cointrack/domain/entities/coin_detail_entity.dart';

class CoinDetailModel extends CoinDetailEntity {
  CoinDetailModel({
    required super.id,
    required super.name,
    required super.symbol,
    required super.rank,
    required super.price,
    required super.changePercent24h,
    required super.marketCap,
    required super.volume24h,
    required super.changePercent1h,
    required super.changePercent7d,
    required super.changePercent30d,
    required super.changePercent1y,
  });

  factory CoinDetailModel.fromJson(Map<String, dynamic> json) {
    double d(dynamic v) {
      if (v == null) return 0.0;
      if (v is num) return v.toDouble();
      return double.tryParse(v.toString()) ?? 0.0;
    }

    int i(dynamic v) {
      if (v == null) return 0;
      if (v is num) return v.toInt();
      return int.tryParse(v.toString()) ?? 0;
    }

    // Formato da API com quotes.USD
    final quotes = json['quotes'] ?? {};
    final usd = quotes['USD'] ?? {};

    return CoinDetailModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      symbol: json['symbol']?.toString() ?? '',
      rank: i(json['rank']),
      price: d(usd['price']),
      changePercent24h: d(usd['percent_change_24h']),
      marketCap: d(usd['market_cap']),
      volume24h: d(usd['volume_24h']),
      changePercent1h: d(usd['percent_change_1h']),
      changePercent7d: d(usd['percent_change_7d']),
      changePercent30d: d(usd['percent_change_30d']),
      changePercent1y: d(usd['percent_change_1y']),
    );
  }
}
