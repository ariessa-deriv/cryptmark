// import 'dart:convert';
// import 'package:http/http.dart' as http;      //import it as http
// import '../models/cryptmark_model.dart';
// import '../models/search_model.dart';
//
// class SearchService {
//   Future<SearchModel> fetchSearchInformation({String? coinName}) async {
//     //the Future takes times to prepare the results
//     final Uri url = Uri(
//       scheme: 'https',
//       host: 'api.coingecko.com',
//       path: 'api/v3/search',
//       queryParameters: {
//         'query': coinName,
//       },
//     );
//     http.Response response = await http.get(url);
//
//     if (response.statusCode == 200) {
//       return SearchModel.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to coins information.');
//     }
//   }
// }