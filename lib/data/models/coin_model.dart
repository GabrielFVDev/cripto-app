import 'package:cointrack/domain/entities/coin_entity.dart';

class CoinModel extends CoinEntity {
  CoinModel({
    required super.id,
    required super.name,
    required super.symbol,
    required super.rank,
    required super.price,
    required super.changePercent24h,
  });

  factory CoinModel.fromJson(Map<String, dynamic> json) {
    try {
      // Função auxiliar para converter valores para double de forma segura
      double safeToDouble(dynamic value) {
        if (value == null) return 0.0;
        if (value is double) return value;
        if (value is int) return value.toDouble();
        if (value is String) {
          return double.tryParse(value) ?? 0.0;
        }
        return 0.0;
      }

      // Função auxiliar para converter valores para int de forma segura
      int safeToInt(dynamic value) {
        if (value == null) return 0;
        if (value is int) return value;
        if (value is double) return value.toInt();
        if (value is String) {
          return int.tryParse(value) ?? 0;
        }
        return 0;
      }

      return CoinModel(
        id: json['id']?.toString() ?? '',
        name: json['name']?.toString() ?? '',
        symbol: json['symbol']?.toString() ?? '',
        rank: safeToInt(json['rank']),
        price: safeToDouble(json['quotes']?['USD']?['price']),
        changePercent24h: safeToDouble(
          json['quotes']?['USD']?['percent_change_24h'],
        ),
      );
    } catch (e) {
      // Retorna um objeto com valores padrão em caso de erro
      return CoinModel(
        id: 'unknown',
        name: 'Unknown',
        symbol: 'UNK',
        rank: 0,
        price: 0.0,
        changePercent24h: 0.0,
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'symbol': symbol,
      'rank': rank,
      'quotes': {
        'USD': {
          'price': price,
          'percent_change_24h': changePercent24h,
        },
      },
    };
  }
}
