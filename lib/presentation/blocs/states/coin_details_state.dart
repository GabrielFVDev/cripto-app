import 'package:cointrack/domain/domain.dart';

class CoinDetailsState {}

class CoinDetailsInitial extends CoinDetailsState {}

class CoinDetailsLoading extends CoinDetailsState {}

class CoinDetailsLoaded extends CoinDetailsState {
  final CoinDetailEntity details;
  final List<PricePointEntity> history;
  CoinDetailsLoaded({required this.details, required this.history});
}

class CoinDetailsError extends CoinDetailsState {
  final String message;
  CoinDetailsError(this.message);
}
