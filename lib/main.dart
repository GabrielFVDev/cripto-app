import 'package:cointrack/core/constants/api_constants.dart';
import 'package:cointrack/core/constants/routes.dart';
import 'package:cointrack/data/data.dart';
import 'package:cointrack/domain/domain.dart';
import 'package:cointrack/presentation/blocs/bloc.dart';
import 'package:cointrack/presentation/blocs/bloc/coin_details_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final dio = Dio(BaseOptions(baseUrl: baseUrl));
  final coinService = CoinRemoteService(dio);
  final coinRepository = CoinRepositoryImpl(coinService);
  final getCoins = GetCoins(coinRepository);
  final getDetails = GetCoinDetails(coinRepository);
  final getHistory = GetCoinHistory7d(coinRepository);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CoinBloc(getCoins)),
        BlocProvider(
          create: (_) => CoinDetailsBloc(
            getDetails: getDetails,
            getHistory: getHistory,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'CoinTrack',

      routerConfig: router,
    );
  }
}
