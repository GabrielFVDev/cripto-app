import 'package:cointrack/core/constants/app_colors.dart';
import 'package:cointrack/presentation/blocs/bloc.dart';
import 'package:cointrack/presentation/widgets/cards/performance_card.dart';
import 'package:cointrack/presentation/widgets/cards/status_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsPage extends StatefulWidget {
  final String coinId;
  const DetailsPage({super.key, required this.coinId});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  String _formatLargeNumber(double value) {
    if (value >= 1e12) {
      return '\$${(value / 1e12).toStringAsFixed(2)}T';
    } else if (value >= 1e9) {
      return '\$${(value / 1e9).toStringAsFixed(2)}B';
    } else if (value >= 1e6) {
      return '\$${(value / 1e6).toStringAsFixed(2)}M';
    } else if (value >= 1e3) {
      return '\$${(value / 1e3).toStringAsFixed(2)}K';
    } else {
      return '\$${value.toStringAsFixed(2)}';
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<CoinDetailsBloc>().add(LoadCoinDetails(widget.coinId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoinDetailsBloc, CoinDetailsState>(
      builder: (context, state) {
        String title = widget.coinId.toUpperCase();
        Widget content;
        if (state is CoinDetailsLoading || state is CoinDetailsInitial) {
          content = const Center(child: CircularProgressIndicator());
        } else if (state is CoinDetailsError) {
          content = Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else if (state is CoinDetailsLoaded) {
          final d = state.details;
          title = d.name;
          final history = state.history;
          var spots = history
              .asMap()
              .entries
              .map((e) => FlSpot(e.key.toDouble(), e.value.price))
              .toList();
          if (spots.length == 1) {
            spots = [FlSpot(0, spots.first.y), FlSpot(1, spots.first.y)];
          }
          content = SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.finalBlue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            d.symbol,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              d.name,
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Text(
                                  d.formattedPrice,
                                  style: const TextStyle(
                                    color: AppColors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Row(
                                  children: [
                                    Icon(
                                      d.isPositive
                                          ? Icons.trending_up
                                          : Icons.trending_down,
                                      color: d.isPositive
                                          ? Colors.green
                                          : Colors.red,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      d.formattedChange,
                                      style: TextStyle(
                                        color: d.isPositive
                                            ? Colors.green
                                            : Colors.red,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Últimas 24 horas',
                              style: TextStyle(
                                color: AppColors.whiteWithOpacity80,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Chart card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Gráfico (7 dias)',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 180,
                        child: LineChart(
                          LineChartData(
                            titlesData: FlTitlesData(show: false),
                            gridData: const FlGridData(show: false),
                            borderData: FlBorderData(show: false),
                            lineBarsData: [
                              LineChartBarData(
                                spots: spots,
                                isCurved: true,
                                color: Colors.green,
                                barWidth: 2,
                                dotData: const FlDotData(show: false),
                                belowBarData: BarAreaData(
                                  show: true,
                                  color: Colors.green.withOpacity(0.2),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Stats
                Row(
                  children: [
                    Expanded(
                      child: StatusCard(
                        title: 'Market Cap',
                        value: _formatLargeNumber(d.marketCap),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: StatusCard(
                        title: 'Volume 24h',
                        value: _formatLargeNumber(d.volume24h),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Performance temporal
                const Text(
                  'Performance',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: PerformanceCard(
                        title: '1 Hora',
                        value: d.formattedChange.replaceAll(
                          d.changePercent24h.toStringAsFixed(2),
                          d.changePercent1h.toStringAsFixed(2),
                        ),
                        isPositive: d.changePercent1h > 0,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: PerformanceCard(
                        title: '7 Dias',
                        value: d.formattedChange7d,
                        isPositive: d.isPositive7d,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: PerformanceCard(
                        title: '30 Dias',
                        value: d.formattedChange30d,
                        isPositive: d.isPositive30d,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: PerformanceCard(
                        title: '1 Ano',
                        value: d.formattedChange1y,
                        isPositive: d.isPositive1y,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          content = const SizedBox.shrink();
        }

        return Scaffold(
          backgroundColor: AppColors.appBarBackground,
          appBar: AppBar(
            backgroundColor: AppColors.appBarBackground,
            title: Text(title, style: const TextStyle(color: AppColors.white)),
            iconTheme: const IconThemeData(color: AppColors.white),
          ),
          body: content,
        );
      },
    );
  }
}
