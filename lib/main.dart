import 'package:cointrack/core/constants/api_constants.dart';
import 'package:cointrack/core/constants/font_text.dart';
import 'package:cointrack/core/constants/routes.dart';
import 'package:cointrack/data/data.dart';
import 'package:cointrack/domain/domain.dart';
import 'package:cointrack/presentation/blocs/bloc.dart';
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
      debugShowCheckedModeBanner: false,
      title: 'CoinTrack',
      routerConfig: router,
      theme: ThemeData(
        fontFamily: 'Roboto',
        textTheme: TextTheme(
          bodyLarge: FontText.bodyLarge,
          bodyMedium: FontText.bodyMedium,
          bodySmall: FontText.bodySmall,
          labelLarge: FontText.labelLarge,
          labelMedium: FontText.labelMedium,
          labelSmall: FontText.labelSmall,
        ),
      ),
    );
  }
}
