import 'package:cointrack/data/models/coin_model.dart';
import 'package:dio/dio.dart';

class CoinRemoteService {
  final Dio dio;

  CoinRemoteService(this.dio);

  Future<List<CoinModel>> fetchCoins() async {
    try {
      final response = await dio.get('/tickers');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        // Filtrar apenas moedas com dados válidos e limitar a 100
        final validCoins = data
            .where(
              (coin) =>
                  coin != null &&
                  coin['quotes'] != null &&
                  coin['quotes']['USD'] != null &&
                  coin['quotes']['USD']['price'] != null,
            )
            .take(100) // Limitar a 100 moedas para evitar sobrecarga
            .map((coin) => CoinModel.fromJson(coin))
            .where(
              (coinModel) => coinModel.id != 'unknown',
            ) // Filtrar moedas com erro de parsing
            .toList();

        return validCoins;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Failed to load coins: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
