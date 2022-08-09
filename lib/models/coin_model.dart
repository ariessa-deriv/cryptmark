import 'dart:convert';

class CoinModel {
  CoinModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.marketCap,
    required this.marketCapRank,
    required this.fullyDilutedValuation,
    required this.totalVolume,
    required this.high24H,
    required this.low24H,
    required this.priceChange24H,
    required this.priceChangePercentage24H,
    required this.marketCapChange24H,
    required this.marketCapChangePercentage24H,
    required this.circulatingSupply,
    required this.totalSupply,
    required this.maxSupply,
    required this.ath,
    required this.athChangePercentage,
    required this.athDate,
    required this.atl,
    required this.atlChangePercentage,
    required this.atlDate,
    required this.roi,
    required this.lastUpdated,
    required this.priceChangePercentage1HInCurrency,
    required this.priceChangePercentage24HInCurrency,
    required this.priceChangePercentage7DInCurrency,
  });

  final String id;
  final String symbol;
  final String name;
  final String image;
  final int currentPrice;
  final int marketCap;
  final int marketCapRank;
  final int fullyDilutedValuation;
  final int totalVolume;
  final int high24H;
  final int low24H;
  final double priceChange24H;
  final double priceChangePercentage24H;
  final int marketCapChange24H;
  final double marketCapChangePercentage24H;
  final int circulatingSupply;
  final int totalSupply;
  final int maxSupply;
  final int ath;
  final double athChangePercentage;
  final DateTime athDate;
  final double atl;
  final double atlChangePercentage;
  final DateTime atlDate;
  final dynamic roi;
  final DateTime lastUpdated;
  final double priceChangePercentage1HInCurrency;
  final double priceChangePercentage24HInCurrency;
  final double priceChangePercentage7DInCurrency;

  factory CoinModel.fromJson(String str) => CoinModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CoinModel.fromMap(Map<String, dynamic> json) => CoinModel(
        id: json["id"],
        symbol: json["symbol"],
        name: json["name"],
        image: json["image"],
        currentPrice: json["current_price"],
        marketCap: json["market_cap"],
        marketCapRank: json["market_cap_rank"],
        fullyDilutedValuation: json["fully_diluted_valuation"],
        totalVolume: json["total_volume"],
        high24H: json["high_24h"],
        low24H: json["low_24h"],
        priceChange24H: json["price_change_24h"].toDouble(),
        priceChangePercentage24H:
            json["price_change_percentage_24h"].toDouble(),
        marketCapChange24H: json["market_cap_change_24h"],
        marketCapChangePercentage24H:
            json["market_cap_change_percentage_24h"].toDouble(),
        circulatingSupply: json["circulating_supply"],
        totalSupply: json["total_supply"],
        maxSupply: json["max_supply"],
        ath: json["ath"],
        athChangePercentage: json["ath_change_percentage"].toDouble(),
        athDate: DateTime.parse(json["ath_date"]),
        atl: json["atl"].toDouble(),
        atlChangePercentage: json["atl_change_percentage"].toDouble(),
        atlDate: DateTime.parse(json["atl_date"]),
        roi: json["roi"],
        lastUpdated: DateTime.parse(json["last_updated"]),
        priceChangePercentage1HInCurrency:
            json["price_change_percentage_1h_in_currency"].toDouble(),
        priceChangePercentage24HInCurrency:
            json["price_change_percentage_24h_in_currency"].toDouble(),
        priceChangePercentage7DInCurrency:
            json["price_change_percentage_7d_in_currency"].toDouble(),
      );

  List<Map<String, dynamic>> toMap() => [
        {
          "id": id,
          "symbol": symbol,
          "name": name,
          "image": image,
          "current_price": currentPrice,
          "market_cap": marketCap,
          "market_cap_rank": marketCapRank,
          "fully_diluted_valuation": fullyDilutedValuation,
          "total_volume": totalVolume,
          "high_24h": high24H,
          "low_24h": low24H,
          "price_change_24h": priceChange24H,
          "price_change_percentage_24h": priceChangePercentage24H,
          "market_cap_change_24h": marketCapChange24H,
          "market_cap_change_percentage_24h": marketCapChangePercentage24H,
          "circulating_supply": circulatingSupply,
          "total_supply": totalSupply,
          "max_supply": maxSupply,
          "ath": ath,
          "ath_change_percentage": athChangePercentage,
          "ath_date": athDate.toIso8601String(),
          "atl": atl,
          "atl_change_percentage": atlChangePercentage,
          "atl_date": atlDate.toIso8601String(),
          "roi": roi,
          "last_updated": lastUpdated.toIso8601String(),
          "price_change_percentage_1h_in_currency":
              priceChangePercentage1HInCurrency,
          "price_change_percentage_24h_in_currency":
              priceChangePercentage24HInCurrency,
          "price_change_percentage_7d_in_currency":
              priceChangePercentage7DInCurrency,
        }
      ];
}