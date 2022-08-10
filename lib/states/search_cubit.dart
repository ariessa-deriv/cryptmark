// import 'package:cryptmark/states/search_state.dart';
//
// import '../models/search_model.dart';
// import '../services/search_service.dart';
// import 'coin_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:cryptmark/models/cryptmark_model.dart';
// import 'package:cryptmark/services/cryptmark_service.dart';
//
// class SearchCubit extends Cubit<SearchState> {
//   SearchCubit() : super(SearchLoading());
//
//   Future<void> fetchSearch(String coinID) async {
//     SearchService searchService = SearchService();
//
//     emit(SearchLoading());
//
//     try {
//       SearchModel searchModel =
//       await searchService.fetchSearchInformation(coinName: coinID);
//       emit(SearchLoaded(searchModel: searchModel));
//     } catch (e) {
//       emit(SearchError(errorMessage: e.toString()));
//     }
//   }
// }