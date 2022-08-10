import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/coin_model.dart';

class CoinService {
  Future<List<dynamic>> fetchCoinInformation() async {
    final Uri url = Uri(
      scheme: 'https',
      host: 'api.coingecko.com',
      path: 'api/v3/coins/markets',
      queryParameters: {
        'vs_currency': 'usd',
        'order': 'market_cap_desc',
        'per_page': '50',
        'page': '1',
        'price_change_percentage': '1h,24h,7d',
        'ids':
            'bitcoin,ethereum,tether,usd-coin,binancecoin,binance-usd,ripple,cardano,solana,dogecoin,polkadot,matic-network,defichain,dai,avalanche-2,tron,staked-ether,wrapped-bitcoin,leo-token,litecoin,ftx-token,okb,uniswap,crypto-com-chain,chainlink,ethereum-classic,near,stellar,cosmos,monero,algorand,bitcoin-cash,flow,vechain,chain-2,apecoin,theta-fuel,internet-computer,the-sandbox,decentraland,hedera-hashgraph,tezos,filecoin,quant-network,axie-infinity,frax,elrond-erd-2,aave,theta-token,true-usd'
      },
    );
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      return List<dynamic>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load coins information.');
    }
  }
}
