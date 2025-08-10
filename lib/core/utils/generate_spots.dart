import 'package:fl_chart/fl_chart.dart';

List<FlSpot> generateSpotsForPeriod(
  double currentPrice,
  double percentageChange,
) {
  final points = <FlSpot>[];
  final startPrice = currentPrice / (1 + (percentageChange / 100));

  // Gerar 10 pontos suaves entre o preço inicial e final
  for (int i = 0; i < 10; i++) {
    final progress = i / 9.0;
    final price = startPrice + (currentPrice - startPrice) * progress;
    points.add(FlSpot(i.toDouble(), price));
  }

  return points;
}
