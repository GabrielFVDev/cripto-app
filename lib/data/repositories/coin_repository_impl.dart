import 'package:cripto_app/data/models/coin_model.dart';
import 'package:cripto_app/data/service/coin_remote_service.dart';
import 'package:cripto_app/domain/repositories/coin_repository.dart';

class CoinRepositoryImpl implements CoinRepository {
  final CoinRemoteService remoteService;

  CoinRepositoryImpl(this.remoteService);

  @override
  Future<List<CoinModel>> fetchCoins() {
    return remoteService.fetchCoins();
  }
}
