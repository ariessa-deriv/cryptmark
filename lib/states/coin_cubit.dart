import 'package:cryptmark/models/cryptmark_model.dart';
import 'package:cryptmark/services/cryptmark_service.dart';
import 'package:cryptmark/states/coin_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoinCubit extends Cubit<CoinState> {
  CoinCubit() : super(CoinLoading());

  Future<void> fetchCryptmark(String cityName) async {            //
    CryptmarkService coinService = CryptmarkService();

    emit(CoinLoading());

    try {
      CryptmarkModel cryptmarkModel =
          await coinService.fetchCryptMarkInformation();
      emit(CoinLoaded(cryptmarkModel: cryptmarkModel));
    } catch (e) {
      emit(CoinError(errorMessage: e.toString()));
    }
  }
}
