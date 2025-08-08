import 'package:flutter/material.dart';
import '../../../data/models/crypto_data.dart';
import 'crypto_list_item.dart';

class CryptoList extends StatelessWidget {
  final List<CryptoData> cryptoList;
  final Function(CryptoData)? onCryptoTap;

  const CryptoList({
    super.key,
    required this.cryptoList,
    this.onCryptoTap,
  });

  @override
  Widget build(BuildContext context) {
    if (cryptoList.isEmpty) {
      return const Center(
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
      );
    }

    return Column(
      children: cryptoList
          .map(
            (crypto) => CryptoListItem(
              crypto: crypto,
              onTap: onCryptoTap != null ? () => onCryptoTap!(crypto) : null,
            ),
          )
          .toList(),
    );
  }
}
