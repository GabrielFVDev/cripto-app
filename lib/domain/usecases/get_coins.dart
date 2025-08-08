import 'package:cointrack/domain/entities/coin_entity.dart';
import 'package:cointrack/domain/repositories/coin_repository.dart';

class GetCoins {
  final CoinRepository repository;

  GetCoins(this.repository);

  Future<List<CoinEntity>> execute() {
    return repository.fetchCoins();
  }
}
