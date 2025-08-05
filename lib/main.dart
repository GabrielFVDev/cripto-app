import 'package:cripto_app/core/constants/api_constants.dart';
import 'package:cripto_app/core/constants/routes.dart';
import 'package:cripto_app/data/data.dart';
import 'package:cripto_app/domain/domain.dart';
import 'package:cripto_app/presentation/blocs/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final dio = Dio(BaseOptions(baseUrl: baseUrl));
  final coinService = CoinRemoteService(dio);
  final coinRepository = CoinRepositoryImpl(coinService);
  final getCoins = GetCoins(coinRepository);

  runApp(
    BlocProvider(
      create: (_) => CoinBloc(getCoins),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Cripto App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: router,
    );
  }
}
