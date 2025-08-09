import 'package:cointrack/domain/entities/price_point_entity.dart';
import 'package:cointrack/domain/repositories/coin_repository.dart';

class GetCoinHistory7d {
  final CoinRepository repository;
  GetCoinHistory7d(this.repository);

  Future<List<PricePointEntity>> execute(String coinId) =>
      repository.fetchCoinHistory7d(coinId);
}
