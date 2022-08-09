import 'package:cryptmark/models/coin_model.dart';

abstract class CoinState {}

class CoinLoading extends CoinState {}

class CoinLoaded extends CoinState {
  final List<CoinModel> coinModel;

  CoinLoaded({required this.coinModel});
}

class CoinError extends CoinState {
  final String errorMessage;

  CoinError({required this.errorMessage});
}
