import 'package:cripto_app/data/models/coin_model.dart';
import 'package:cripto_app/domain/repositories/coin_repository.dart';

class GetCoins {
  final CoinRepository repository;

  GetCoins(this.repository);

  Future<List<CoinModel>> execute() {
    return repository.fetchCoins();
  }
}
