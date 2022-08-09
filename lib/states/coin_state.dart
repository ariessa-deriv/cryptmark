import 'package:cryptmark/models/cryptmark_model.dart';

abstract class CoinState {}

class CoinLoading extends CoinState {}

class CoinLoaded extends CoinState {
  final CryptmarkModel cryptmarkModel;

  CoinLoaded({required this.cryptmarkModel});
}

class CoinError extends CoinState {
  final String errorMessage;

  CoinError({required this.errorMessage});
}
