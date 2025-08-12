import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cointrack/presentation/blocs/bloc.dart';
import 'package:cointrack/domain/usecases/get_coins.dart';

class CoinBloc extends Bloc<CoinEvent, CoinState> {
  final GetCoins getCoins;

  CoinBloc(this.getCoins) : super(CoinInitial()) {
    on<FetchCoinsEvent>((event, emit) async {
      emit(CoinLoading());
      try {
        final coins = await getCoins.execute();
        emit(CoinLoaded(coins));
      } catch (e) {
        print('Erro na API: $e'); // Para debug
        emit(CoinError('Erro ao buscar moedas: ${e.toString()}'));
      }
    });
  }
}
