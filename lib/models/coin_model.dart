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
}
