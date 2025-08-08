import 'package:cointrack/domain/entities/coin_entity.dart';

abstract class CoinRepository {
  Future<List<CoinEntity>> fetchCoins();
}
