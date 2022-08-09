import 'dart:convert';

class CryptmarkModel {
  CryptmarkModel({
    required this.id,
    // required this.symbol,
    // required this.name,
    // required this.image,
    // required this.currentPrice,
    // required this.marketCap,
    // required this.circulatingSupply,
    // required this.totalSupply,
    // required this.maxSupply,
    // required this.priceChangePercentage1HInCurrency,
    // required this.priceChangePercentage24HInCurrency,
    // required this.priceChangePercentage7DInCurrency,
  });

  final String id;
  // final String symbol;
  // final String name;
  // final String image;
  // final double currentPrice;
  // final int marketCap;
  // final double circulatingSupply;
  // final double totalSupply;
  // final double maxSupply;
  // final double priceChangePercentage1HInCurrency;
  // final double priceChangePercentage24HInCurrency;
  // final double priceChangePercentage7DInCurrency;

  factory CryptmarkModel.fromJson(String str) => CryptmarkModel.fromMap(json.decode(str));

  factory CryptmarkModel.fromMap(List<dynamic> json) => CryptmarkModel(
    id: json[0],
    // symbol: json["symbol"],
    // name: json["name"],
    // image: json["image"],
    // currentPrice: json["current_price"].toDouble(),
    // marketCap: json["market_cap"],
    // circulatingSupply: json["circulating_supply"].toDouble(),
    // totalSupply: json["total_supply"] == null ? null : json["total_supply"].toDouble(),
    // maxSupply: json["max_supply"] == null ? null : json["max_supply"].toDouble(),
    // priceChangePercentage1HInCurrency: json["price_change_percentage_1h_in_currency"].toDouble(),
    // priceChangePercentage24HInCurrency: json["price_change_percentage_24h_in_currency"].toDouble(),
    // priceChangePercentage7DInCurrency: json["price_change_percentage_7d_in_currency"].toDouble(),
  );
}

