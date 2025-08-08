import 'package:flutter/material.dart';
import '../models/crypto_data.dart';

class CryptoDataService {
  static List<CryptoData> getCryptoList() {
    return [
      CryptoData(
        name: 'Bitcoin',
        symbol: 'BTC',
        price: 43250.00,
        change: 2.45,
        icon: '₿',
        iconColor: Colors.orange,
      ),
      CryptoData(
        name: 'Ethereum',
        symbol: 'ETH',
        price: 2580.50,
        change: -1.23,
        icon: 'Ξ',
        iconColor: Colors.blue,
      ),
      CryptoData(
        name: 'BNB',
        symbol: 'BNB',
        price: 315.20,
        change: 3.67,
        icon: '●',
        iconColor: Colors.yellow,
      ),
      CryptoData(
        name: 'Solana',
        symbol: 'SOL',
        price: 98.75,
        change: 5.12,
        icon: '◆',
        iconColor: Colors.purple,
      ),
      CryptoData(
        name: 'Cardano',
        symbol: 'ADA',
        price: 0.4850,
        change: -2.15,
        icon: '▲',
        iconColor: Colors.blue.shade300,
      ),
      CryptoData(
        name: 'Avalanche',
        symbol: 'AVAX',
        price: 36.80,
        change: 4.23,
        icon: '▲',
        iconColor: Colors.red,
      ),
    ];
  }

  static List<CryptoData> searchCrypto(
    List<CryptoData> cryptoList,
    String query,
  ) {
    if (query.isEmpty) return cryptoList;

    return cryptoList.where((crypto) {
      return crypto.name.toLowerCase().contains(query.toLowerCase()) ||
          crypto.symbol.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
