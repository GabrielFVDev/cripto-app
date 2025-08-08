import 'package:cointrack/data/service/coin_remote_service.dart';
import 'package:cointrack/domain/entities/coin_entity.dart';
import 'package:cointrack/domain/repositories/coin_repository.dart';

class CoinRepositoryImpl implements CoinRepository {
  final CoinRemoteService remoteService;

  CoinRepositoryImpl(this.remoteService);

  @override
  Future<List<CoinEntity>> fetchCoins() async {
    final coinModels = await remoteService.fetchCoins();
    return coinModels;
  }
}
