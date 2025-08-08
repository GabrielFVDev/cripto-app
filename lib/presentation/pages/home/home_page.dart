import 'package:cointrack/core/constants/app_colors.dart';
import 'package:cointrack/data/models/crypto_data.dart';
import 'package:cointrack/data/services/crypto_data_service.dart';
import 'package:cointrack/presentation/widgets/appbar/coin_tracker_app_bar.dart';
import 'package:cointrack/presentation/widgets/cards/coin_tracker_card.dart';
import 'package:cointrack/presentation/widgets/crypto/crypto_list_item.dart';
import 'package:cointrack/presentation/widgets/search/crypto_search_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  List<CryptoData> _allCryptoList = [];
  List<CryptoData> _filteredCryptoList = [];

  @override
  void initState() {
    super.initState();
    _allCryptoList = CryptoDataService.getCryptoList();
    _filteredCryptoList = _allCryptoList;
  }

  void _filterCryptoList(String query) {
    setState(() {
      _filteredCryptoList = CryptoDataService.searchCrypto(
        _allCryptoList,
        query,
      );
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
        onPressed: () {
          setState(() {
            _isSearching = !_isSearching;
          });
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 24),

              CoinTrackerCard(
                title: 'Mercado de Criptomonedas',
                description:
                    'Acompanhe as principais moedas digitais em tempo real',
              ),

              const SizedBox(height: 20),

              // Search Bar
              CryptoSearchBar(
                controller: _searchController,
                onChanged: _filterCryptoList,
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

              // Lista de Criptomoedas
              _filteredCryptoList.isEmpty
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
                  : Column(
                      children: _filteredCryptoList
                          .map(
                            (crypto) => CryptoListItem(
                              crypto: crypto,
                              onTap: () {
                                // Implementar navegação para detalhes
                                print('Tapped on ${crypto.name}');
                              },
                            ),
                          )
                          .toList(),
                    ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
