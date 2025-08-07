import 'package:cointrack/presentation/widgets/appbar/coin_tracker_app_bar.dart';
import 'package:cointrack/presentation/widgets/cards/coin_tracker_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F131A),
      appBar: CoinTrackerAppBar(
        title: 'CoinTracker',
        onPressed: () {
          // Implement search before
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              CoinTrackerCard(
                title: 'Mercado de Criptomonedas',
                description:
                    'Acompanhe as principais moedas digitais em tempo real',
              ),
              // Add more widgets here for the home page content
            ],
          ),
        ),
      ),
    );
  }
}
