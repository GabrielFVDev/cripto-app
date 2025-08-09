import 'package:cointrack/domain/domain.dart';
import 'package:cointrack/presentation/blocs/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoinDetailsBloc extends Bloc<CoinDetailsEvent, CoinDetailsState> {
  final GetCoinDetails getDetails;
  final GetCoinHistory7d getHistory;

  CoinDetailsBloc({required this.getDetails, required this.getHistory})
    : super(CoinDetailsInitial()) {
    on<LoadCoinDetails>((event, emit) async {
      emit(CoinDetailsLoading());
      try {
        final details = await getDetails.execute(event.coinId);
        final history = await getHistory.execute(event.coinId);
        emit(CoinDetailsLoaded(details: details, history: history));
      } catch (e) {
        emit(CoinDetailsError('Erro ao carregar detalhes'));
      }
    });
  }
}
