class CoinDetailsEvent {}

class LoadCoinDetails extends CoinDetailsEvent {
  final String coinId;
  LoadCoinDetails(this.coinId);
}
