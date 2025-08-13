import 'package:cointrack/core/constants/app_colors.dart';
import 'package:cointrack/core/constants/font_text.dart';
import 'package:cointrack/domain/entities/coin_entity.dart';
import 'package:cointrack/presentation/blocs/bloc.dart';
import 'package:cointrack/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<CoinEntity> _filteredCoinList = [];
  List<CoinEntity> _allCoinList = [];

  @override
  void initState() {
    super.initState();
    context.read<CoinBloc>().add(FetchCoinsEvent());
  }

  void _filterCoinList(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredCoinList = _allCoinList;
      } else {
        _filteredCoinList = _allCoinList
            .where(
              (coin) =>
                  coin.name.toLowerCase().contains(query.toLowerCase()) ||
                  coin.symbol.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBarBackground,
      appBar: CoinTrackerAppBar(
        title: 'CoinTracker',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 8),
              CoinTrackerCard(
                title: 'Mercado de Criptomonedas',
                description:
                    'Acompanhe as principais moedas digitais em tempo real',
              ),
              const SizedBox(height: 24),
              // Search Bar
              CryptoSearchBar(
                controller: _searchController,
                onChanged: _filterCoinList,
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Text(
                      "Principais Moedas",
                      style: FontText.titleLarge,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Lista de Criptomoedas usando BlocBuilder
              BlocBuilder<CoinBloc, CoinState>(
                builder: (context, state) {
                  if (state is CoinLoading) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                        ),
                      ),
                    );
                  } else if (state is CoinError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          children: [
                            Text(
                              state.message,
                              style: FontText.bodyLarge.copyWith(
                                color: Colors.red,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                context.read<CoinBloc>().add(FetchCoinsEvent());
                              },
                              child: Text(
                                'Tentar novamente',
                                style: FontText.labelMedium.copyWith(
                                  color: AppColors.blackVariation,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (state is CoinLoaded) {
                    _allCoinList = state.coins
                        .take(64)
                        .toList(); // Limitar a 64 moedas
                    if (_filteredCoinList.isEmpty &&
                        _searchController.text.isEmpty) {
                      _filteredCoinList = _allCoinList;
                    }

                    return _filteredCoinList.isEmpty
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(32.0),
                              child: Text(
                                'Nenhuma criptomoeda encontrada',
                                style: FontText.bodyLarge,
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _filteredCoinList.length,
                                itemBuilder: (context, index) {
                                  final coin = _filteredCoinList[index];
                                  final isLast =
                                      index == _filteredCoinList.length - 1;
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      bottom: isLast ? 40.0 : 0.0,
                                    ),
                                    child: CoinListItem(
                                      coin: coin,
                                      onTap: () =>
                                          context.push('/details/${coin.id}'),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                  }

                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Text(
                        'Pressione o botão para carregar as moedas',
                        style: FontText.titleLarge.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
