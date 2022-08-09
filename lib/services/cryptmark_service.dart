import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../models/cryptmark_model.dart'; // import it as http

class CryptmarkService {
  Future<CryptmarkModel> fetchCryptMarkInformation() async {
    //the Future takes times to prepare the results
    final Uri url = Uri(
      scheme: 'https',
      host: 'api.coingecko.com',
      path: 'api/v3/coins/markets',
      queryParameters: {
        'vs_currency': 'usd',
        'order': 'market_cap_desc',
        'per_page': '50',
        'page': '1',
        'price_change_percentage': '1h,24h,7d'
      },
    );
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      return CryptmarkModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather information.');
    }
  }
}
