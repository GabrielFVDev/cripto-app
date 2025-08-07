import 'package:cointrack/data/models/coin_model.dart';
import 'package:dio/dio.dart';

class CoinRemoteService {
  final Dio dio;

  CoinRemoteService(this.dio);

  Future<List<CoinModel>> fetchCoins() async {
    final response = await dio.get('/tickers');
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['data'];
      return data.map((coin) => CoinModel.fromJson(coin)).toList();
    } else {
      throw Exception('Failed to load coins');
    }
  }
}
