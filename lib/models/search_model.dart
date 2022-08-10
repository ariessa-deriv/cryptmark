// import 'package:meta/meta.dart';
// import 'dart:convert';
//
// class SearchModel {
//   SearchModel({
//     required this.coins,
//     required this.exchanges,
//     required this.icos,
//     required this.categories,
//     required this.nfts,
//   });
//
//   final List<Coin> coins;
//   final List<Exchange> exchanges;
//   final List<dynamic> icos;
//   final List<Category> categories;
//   final List<Nft> nfts;
//
//   factory SearchModel.fromJson(String str) => SearchModel.fromMap(json.decode(str));
//
//   String toJson() => json.encode(toMap());
//
//   factory SearchModel.fromMap(Map<String, dynamic> json) => SearchModel(
//     coins: List<Coin>.from(json["coins"].map((x) => Coin.fromMap(x))),
//     exchanges: List<Exchange>.from(json["exchanges"].map((x) => Exchange.fromMap(x))),
//     icos: List<dynamic>.from(json["icos"].map((x) => x)),
//     categories: List<Category>.from(json["categories"].map((x) => Category.fromMap(x))),
//     nfts: List<Nft>.from(json["nfts"].map((x) => Nft.fromMap(x))),
//   );
//
//   Map<String, dynamic> toMap() => {
//     "coins": List<dynamic>.from(coins.map((x) => x.toMap())),
//     "exchanges": List<dynamic>.from(exchanges.map((x) => x.toMap())),
//     "icos": List<dynamic>.from(icos.map((x) => x)),
//     "categories": List<dynamic>.from(categories.map((x) => x.toMap())),
//     "nfts": List<dynamic>.from(nfts.map((x) => x.toMap())),
//   };
// }
//
// class Category {
//   Category({
//     required this.id,
//     required this.name,
//   });
//
//   final int id;
//   final String name;
//
//   factory Category.fromJson(String str) => Category.fromMap(json.decode(str));
//
//   String toJson() => json.encode(toMap());
//
//   factory Category.fromMap(Map<String, dynamic> json) => Category(
//     id: json["id"],
//     name: json["name"],
//   );
//
//   Map<String, dynamic> toMap() => {
//     "id": id,
//     "name": name,
//   };
// }
//
// class Coin {
//   Coin({
//     required this.id,
//     required this.name,
//     required this.symbol,
//     required this.marketCapRank,
//     required this.thumb,
//     required this.large,
//   });
//
//   final String id;
//   final String name;
//   final String symbol;
//   final int marketCapRank;
//   final String thumb;
//   final String large;
//
//   factory Coin.fromJson(String str) => Coin.fromMap(json.decode(str));
//
//   String toJson() => json.encode(toMap());
//
//   factory Coin.fromMap(Map<String, dynamic> json) => Coin(
//     id: json["id"],
//     name: json["name"],
//     symbol: json["symbol"],
//     marketCapRank: json["market_cap_rank"] == null ? null : json["market_cap_rank"],
//     thumb: json["thumb"],
//     large: json["large"],
//   );
//
//   Map<String, dynamic> toMap() => {
//     "id": id,
//     "name": name,
//     "symbol": symbol,
//     "market_cap_rank": marketCapRank == null ? null : marketCapRank,
//     "thumb": thumb,
//     "large": large,
//   };
// }
//
// class Exchange {
//   Exchange({
//     required this.id,
//     required this.name,
//     required this.marketType,
//     required this.thumb,
//     required this.large,
//   });
//
//   final String id;
//   final String name;
//   final String marketType;
//   final String thumb;
//   final String large;
//
//   factory Exchange.fromJson(String str) => Exchange.fromMap(json.decode(str));
//
//   String toJson() => json.encode(toMap());
//
//   factory Exchange.fromMap(Map<String, dynamic> json) => Exchange(
//     id: json["id"],
//     name: json["name"],
//     marketType: json["market_type"],
//     thumb: json["thumb"],
//     large: json["large"],
//   );
//
//   Map<String, dynamic> toMap() => {
//     "id": id,
//     "name": name,
//     "market_type": marketType,
//     "thumb": thumb,
//     "large": large,
//   };
// }
//
// class Nft {
//   Nft({
//     required this.id,
//     required this.name,
//     required this.symbol,
//     required this.thumb,
//   });
//
//   final String id;
//   final String name;
//   final String symbol;
//   final String thumb;
//
//   factory Nft.fromJson(String str) => Nft.fromMap(json.decode(str));
//
//   String toJson() => json.encode(toMap());
//
//   factory Nft.fromMap(Map<String, dynamic> json) => Nft(
//     id: json["id"] == null ? null : json["id"],
//     name: json["name"],
//     symbol: json["symbol"],
//     thumb: json["thumb"],
//   );
//
//   Map<String, dynamic> toMap() => {
//     "id": id == null ? null : id,
//     "name": name,
//     "symbol": symbol,
//     "thumb": thumb,
//   };
// }
