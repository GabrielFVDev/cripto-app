import 'package:cointrack/domain/entities/price_point_entity.dart';

class PricePointModel extends PricePointEntity {
  const PricePointModel({required super.time, required super.price});

  factory PricePointModel.fromJson(Map<String, dynamic> json) {
    // CoinPaprika historical price item has 'timestamp' and 'price'
    final ts =
        DateTime.tryParse(json['timestamp']?.toString() ?? '') ??
        DateTime.fromMillisecondsSinceEpoch(0);
    final pRaw = json['price'];
    final p = pRaw is num ? pRaw.toDouble() : double.tryParse('$pRaw') ?? 0.0;
    return PricePointModel(time: ts, price: p);
  }
}
