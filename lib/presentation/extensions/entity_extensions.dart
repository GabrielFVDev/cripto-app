import 'package:cointrack/domain/entities/coin_entity.dart';
import 'package:cointrack/domain/entities/coin_detail_entity.dart';
import 'package:cointrack/core/utils/format_numbers.dart';

/// Extensions para formatação na camada de apresentação
/// Mantém as entidades puras seguindo os princípios da Clean Architecture

extension CoinEntityPresentation on CoinEntity {
  String get formattedPrice => formatPrice(price);
  String get formattedChange => formatPercentage(changePercent24h);
}

extension CoinDetailEntityPresentation on CoinDetailEntity {
  String get formattedPrice => formatPrice(price);
  String get formattedChange => formatPercentage(changePercent24h);
  String get formattedChange7d => formatPercentage(changePercent7d);
  String get formattedChange30d => formatPercentage(changePercent30d);
  String get formattedChange1y => formatPercentage(changePercent1y);
  String get formattedMarketCap => formatLargeNumber(marketCap);
  String get formattedVolume24h => formatLargeNumber(volume24h);
}
