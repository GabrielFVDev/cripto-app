import 'package:cripto_app/data/models/coin_model.dart';

abstract class CoinRepository {
  Future<List<CoinModel>> fetchCoins();
}
