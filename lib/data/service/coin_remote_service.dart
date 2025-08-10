import 'package:cointrack/data/models/coin_model.dart';
import 'package:cointrack/data/models/coin_detail_model.dart';
import 'package:cointrack/data/models/price_point_model.dart';
import 'package:dio/dio.dart';

class CoinRemoteService {
  final Dio dio;

  CoinRemoteService(this.dio);

  Future<List<CoinModel>> fetchCoins() async {
    try {
      final response = await dio.get('/cryptos');

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
      final response = await dio.get('/cryptos/$coinId');

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
      // Busca dados atuais com informações de performance
      final response = await dio.get('/cryptos/$coinId/historical');

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        final currentPrice = (data['price'] as num?)?.toDouble() ?? 0.0;
        final change7d = (data['percent_change_7d'] as num?)?.toDouble() ?? 0.0;

        // Criar pontos baseados na variação real de 7 dias
        final points = <PricePointModel>[];
        final now = DateTime.now();

        // Calcular preço de 7 dias atrás baseado no percent_change_7d
        final priceSevenDaysAgo = currentPrice / (1 + (change7d / 100));

        // Criar pontos suaves entre o preço de 7 dias atrás e o atual
        for (int i = 0; i <= 6; i++) {
          final date = now.subtract(Duration(days: 6 - i));
          // Interpolação linear entre preço de 7 dias atrás e atual
          final progress = i / 6.0;
          final price =
              priceSevenDaysAgo + (currentPrice - priceSevenDaysAgo) * progress;

          points.add(
            PricePointModel(
              time: date,
              price: price,
            ),
          );
        }

        return points;
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
