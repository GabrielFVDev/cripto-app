import 'package:cointrack/domain/entities/coin_entity.dart';
import 'package:cointrack/domain/entities/coin_detail_entity.dart';
import 'package:cointrack/domain/entities/price_point_entity.dart';

abstract class CoinRepository {
  Future<List<CoinEntity>> fetchCoins();
  Future<CoinDetailEntity> fetchCoinDetails(String coinId);
  Future<List<PricePointEntity>> fetchCoinHistory7d(String coinId);
}
