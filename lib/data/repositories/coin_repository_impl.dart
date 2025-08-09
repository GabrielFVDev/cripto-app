import 'package:cointrack/data/service/coin_remote_service.dart';
import 'package:cointrack/domain/entities/coin_entity.dart';
import 'package:cointrack/domain/entities/coin_detail_entity.dart';
import 'package:cointrack/domain/entities/price_point_entity.dart';
import 'package:cointrack/domain/repositories/coin_repository.dart';

class CoinRepositoryImpl implements CoinRepository {
  final CoinRemoteService remoteService;

  CoinRepositoryImpl(this.remoteService);

  @override
  Future<List<CoinEntity>> fetchCoins() async {
    final coinModels = await remoteService.fetchCoins();
    return coinModels;
  }

  @override
  Future<CoinDetailEntity> fetchCoinDetails(String coinId) async {
    final model = await remoteService.fetchCoinDetails(coinId);
    return model;
  }

  @override
  Future<List<PricePointEntity>> fetchCoinHistory7d(String coinId) async {
    final models = await remoteService.fetchCoinHistory7d(coinId);
    return models;
  }
}
