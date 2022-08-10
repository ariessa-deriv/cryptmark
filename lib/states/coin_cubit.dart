import 'package:cryptmark/models/coin_model.dart';
import 'package:cryptmark/services/coin_service.dart';
import 'package:cryptmark/states/coin_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoinCubit extends Cubit<CoinState> {
  CoinCubit() : super(CoinLoading());

  Future<void> fetchCoins() async {
    CoinService coinService = CoinService();

    emit(CoinLoading());

    try {
      List<dynamic> coinModel = await coinService.fetchCoinInformation();
      emit(CoinLoaded(coinModel: coinModel));
    } catch (e) {
      emit(CoinError(errorMessage: e.toString()));
    }
  }
}
