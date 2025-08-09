import 'package:cointrack/data/models/coin_model.dart';
import 'package:cointrack/data/models/coin_detail_model.dart';
import 'package:cointrack/data/models/price_point_model.dart';
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

  Future<CoinDetailModel> fetchCoinDetails(String coinId) async {
    try {
      final response = await dio.get('/tickers/$coinId');
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        return CoinDetailModel.fromJson(data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Failed to load coin details: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<List<PricePointModel>> fetchCoinHistory7d(String coinId) async {
    try {
      final now = DateTime.now();
      final start = now.subtract(const Duration(days: 7));
      final startStr =
          '${start.year.toString().padLeft(4, '0')}-${start.month.toString().padLeft(2, '0')}-${start.day.toString().padLeft(2, '0')}';
      final response = await dio.get(
        '/tickers/$coinId/historical',
        queryParameters: {
          'start': startStr,
          'interval': '1d',
        },
      );
      if (response.statusCode == 200) {
        final List data = response.data as List;
        return data.map((e) => PricePointModel.fromJson(e)).toList();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Failed to load history: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
