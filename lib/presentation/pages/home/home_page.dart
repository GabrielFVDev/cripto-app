import 'package:cointrack/core/constants/app_colors.dart';
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
              Row(
                children: [
                  Text(
                    "Principais Moedas",
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
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
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                context.read<CoinBloc>().add(FetchCoinsEvent());
                              },
                              child: const Text('Tentar novamente'),
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
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          )
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * 0.6,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: _filteredCoinList.length,
                              itemBuilder: (context, index) {
                                final coin = _filteredCoinList[index];
                                return CoinListItem(
                                  coin: coin,
                                  onTap: () {
                                    context.push('/details/${coin.id}');
                                  },
                                );
                              },
                            ),
                          );
                  }

                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Text(
                        'Pressione o botão para carregar as moedas',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
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
