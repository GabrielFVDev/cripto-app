import 'package:cointrack/domain/entities/coin_detail_entity.dart';
import 'package:cointrack/domain/repositories/coin_repository.dart';

class GetCoinDetails {
  final CoinRepository repository;
  GetCoinDetails(this.repository);

  Future<CoinDetailEntity> execute(String coinId) =>
      repository.fetchCoinDetails(coinId);
}
