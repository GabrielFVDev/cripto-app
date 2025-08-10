import 'dart:math';
import 'package:fl_chart/fl_chart.dart';

List<FlSpot> generateSpotsForPeriod(
  double currentPrice,
  double percentageChange,
) {
  final points = <FlSpot>[];
  final startPrice = currentPrice / (1 + (percentageChange / 100));
  final random = Random();

  // Número de pontos para criar ondulações
  const numPoints = 20;

  // Calcular a tendência geral (direção do movimento)
  final totalChange = currentPrice - startPrice;

  // Fator de volatilidade baseado na magnitude da mudança percentual
  final volatilityFactor = (percentageChange.abs() / 100) * 0.15 + 0.05;

  double currentValue = startPrice;

  for (int i = 0; i < numPoints; i++) {
    final progress = i / (numPoints - 1);

    // Preço base seguindo a tendência linear
    final linearPrice = startPrice + (totalChange * progress);

    // Adicionar variação aleatória (ondulação)
    final maxVariation = currentPrice * volatilityFactor;
    final variation = (random.nextDouble() - 0.5) * 2 * maxVariation;

    // Suavizar a variação para evitar mudanças muito bruscas
    final smoothingFactor = 0.7;
    currentValue =
        (currentValue * smoothingFactor) +
        ((linearPrice + variation) * (1 - smoothingFactor));

    // Garantir que o primeiro ponto seja o preço inicial
    if (i == 0) {
      currentValue = startPrice;
    }

    // Garantir que o último ponto seja próximo ao preço atual
    if (i == numPoints - 1) {
      currentValue = currentPrice;
    }

    points.add(FlSpot(i.toDouble(), currentValue));
  }

  return points;
}

// Função para gerar dados mais realistas com tendências e reversões
List<FlSpot> generateRealisticSpots(
  double currentPrice,
  double percentageChange, {
  int numberOfPoints = 25,
}) {
  final points = <FlSpot>[];
  final startPrice = currentPrice / (1 + (percentageChange / 100));
  final random = Random();

  final totalChange = currentPrice - startPrice;
  final volatilityFactor = (percentageChange.abs() / 100) * 0.12 + 0.03;

  double currentValue = startPrice;
  double momentum = 0.0;

  for (int i = 0; i < numberOfPoints; i++) {
    final progress = i / (numberOfPoints - 1);

    // Tendência base
    final targetPrice = startPrice + (totalChange * progress);

    // Adicionar momentum e reversões ocasionais
    if (random.nextDouble() < 0.15) {
      // 15% chance de reversão
      momentum *= -0.3;
    }

    // Variação baseada em momentum
    final variation =
        (random.nextDouble() - 0.5) * currentPrice * volatilityFactor;
    momentum = (momentum * 0.8) + (variation * 0.2);

    // Aplicar suavização
    final targetWithMomentum = targetPrice + momentum;
    currentValue = (currentValue * 0.6) + (targetWithMomentum * 0.4);

    // Pontos fixos
    if (i == 0) currentValue = startPrice;
    if (i == numberOfPoints - 1) currentValue = currentPrice;

    points.add(FlSpot(i.toDouble(), currentValue));
  }

  return points;
}

// Função para interpolar pontos e criar mais dados intermediários
List<FlSpot> interpolateSpots(List<FlSpot> originalSpots, int targetCount) {
  if (originalSpots.length >= targetCount) return originalSpots;

  final interpolated = <FlSpot>[];
  final segmentSize = (targetCount - 1) / (originalSpots.length - 1);

  for (int i = 0; i < originalSpots.length - 1; i++) {
    final current = originalSpots[i];
    final next = originalSpots[i + 1];

    final startIndex = (i * segmentSize).round();
    final endIndex = ((i + 1) * segmentSize).round();

    for (int j = startIndex; j < endIndex; j++) {
      final progress = (j - startIndex) / (endIndex - startIndex);
      final y = current.y + (next.y - current.y) * progress;

      // Adicionar pequena variação para tornar mais realista
      final random = Random();
      final variation = (random.nextDouble() - 0.5) * current.y * 0.02;

      interpolated.add(FlSpot(j.toDouble(), y + variation));
    }
  }

  // Adicionar o último ponto
  interpolated.add(FlSpot((targetCount - 1).toDouble(), originalSpots.last.y));

  return interpolated;
}
