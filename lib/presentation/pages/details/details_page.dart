import 'package:cointrack/core/constants/app_colors.dart';
import 'package:cointrack/presentation/blocs/bloc.dart';
import 'package:cointrack/presentation/blocs/bloc/coin_details_bloc.dart';
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
                      child: _statCard(
                        title: 'Market Cap',
                        value:
                            '\$${d.marketCap.toStringAsFixed(2).replaceAllMapped(RegExp(r"\B(?=(\d{3})+(?!\d))"), (m) => ',')}',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _statCard(
                        title: 'Volume 24h',
                        value:
                            '\$${d.volume24h.toStringAsFixed(2).replaceAllMapped(RegExp(r"\B(?=(\d{3})+(?!\d))"), (m) => ',')}',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          content = const SizedBox();
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

  Widget _statCard({required String title, required String value}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppColors.whiteWithOpacity80,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
