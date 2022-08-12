import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cryptmark/models/argument_model.dart';
import 'package:cryptmark/routing/router.dart';
import 'package:cryptmark/states/coin_cubit.dart';
import 'package:cryptmark/states/coin_state.dart';
import 'package:cryptmark/widgets/empty_explore.dart';
import 'package:cryptmark/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/theme_model.dart';
import 'home_page.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  bool _isCoinNameEmpty = true;
  final TextEditingController textController = TextEditingController();
  final String hintText = 'Search for a coin...';
  List<Map<String, dynamic>> coinsList = [];
  List<Map<String, dynamic>> searchedCoinsList = [];
  String searchString = "";
  bool showCircularProgressIndicator = false;
  List<String> coinsListString = [];
  List<String> searchedCoinsListString = [];

  // Show CircularProgressIndicator for 500 milliseconds
  void startTimer() {
    Timer.periodic(const Duration(milliseconds: 500), (t) {
      setState(() {
        showCircularProgressIndicator = false;
      });
      // Stop the timer
      t.cancel();
    });
  }

  void searchCoin(String coinName) {
    List<Map<String, dynamic>> results = [];

    if (coinName.isNotEmpty) {
      results = coinsList
          .where((element) => element['name']
              .toString()
              .toLowerCase()
              .contains(coinName.toLowerCase()))
          .toList();

      print("--------------------------asdfghjkl");
      List<String> temp = [];

      for (var a in results) {
        temp.add(json.encode(a));
      }

      print(temp);

      setState(() {
        searchedCoinsList = results;
        searchedCoinsListString = temp;
      });
    }
  }

  // Get coins list from SharedPreferences
  Future<void> getCoinsListFromSharedPrefs() async {
    // Create an instance of SharedPreferences
    final prefs = await SharedPreferences.getInstance();

    // Get value of 'coinsList' key in SharedPreferences
    List<String>? coinsListFromSharedPrefs = prefs.getStringList('coinsList');

    // If coinsList is not null (the API has been fetched at least once)
    if (coinsListFromSharedPrefs != null) {
      // Convert List<String> to List<Map<String,String>>
      final List<Map<String, dynamic>> mapCoinsList = coinsListFromSharedPrefs
          .map((s) => {
                'id': json.decode(s)['id'],
                'symbol': json.decode(s)["symbol"],
                'name': json.decode(s)["name"],
                'image': json.decode(s)["image"],
                'currentPrice': json.decode(s)["current_price"],
                'marketCap': json.decode(s)["market_cap"],
                'marketCapRank': json.decode(s)["market_cap_rank"],
                'fullyDilutedValuation':
                    json.decode(s)["fully_diluted_valuation"],
                'totalVolume': json.decode(s)["total_volume"],
                'high24H': json.decode(s)["high_24h"],
                'low24H': json.decode(s)["low_24h"],
                'priceChange24H': json.decode(s)["price_change_24h"],
                'priceChangePercentage24H':
                    json.decode(s)["price_change_percentage_24h"],
                'marketCapChange24H': json.decode(s)["market_cap_change_24h"],
                'marketCapChangePercentage24H':
                    json.decode(s)["market_cap_change_percentage_24h"],
                'circulatingSupply': json.decode(s)["circulating_supply"],
                'totalSupply': json.decode(s)["total_supply"],
                'maxSupply': json.decode(s)["max_supply"],
                'ath': json.decode(s)["ath"],
                'athChangePercentage': json.decode(s)["ath_change_percentage"],
                'athDate':
                    DateTime.parse(json.decode(s)["ath_date"]).toString(),
                'atl': json.decode(s)["atl"],
                'atlChangePercentage': json.decode(s)["atl_change_percentage"],
                'atlDate':
                    DateTime.parse(json.decode(s)["atl_date"]).toString(),
                'roi': json.decode(s)["roi"],
                'lastUpdated':
                    DateTime.parse(json.decode(s)["last_updated"]).toString(),
                'priceChangePercentage1HInCurrency':
                    json.decode(s)["price_change_percentage_1h_in_currency"],
                'priceChangePercentage24HInCurrency':
                    json.decode(s)["price_change_percentage_24h_in_currency"],
                'priceChangePercentage7DInCurrency':
                    json.decode(s)["price_change_percentage_7d_in_currency"],
              })
          .toList();

      for (var a in coinsListFromSharedPrefs) {
        a = a.replaceAll('{', '{"');
        a = a.replaceAll(': ', '": "');
        a = a.replaceAll(', ', '", "');
        a = a.replaceAll('}', '"}');
      }

      print(coinsListFromSharedPrefs);

      setState(() {
        coinsList = mapCoinsList;
        coinsListString = coinsListFromSharedPrefs;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // Get coins list from SharedPreferences
    getCoinsListFromSharedPrefs();

    // Attach listener to text controller
    textController.addListener(() {
      setState(
        () => _isCoinNameEmpty = textController.text.isEmpty,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          // Search bar
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  offset: const Offset(12, 26),
                  blurRadius: 50,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.1)),
            ]),
            child: TextField(
              controller: textController,
              onChanged: ((value) {
                setState(() {
                  searchString = value.toLowerCase();
                  showCircularProgressIndicator = true;
                });
                searchCoin(value);
                startTimer();
              }),
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.grey),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
              ),
            ),
          ),
          // If search bar is empty, show suggested coins
          // Else, show filtered list
          _isCoinNameEmpty
              ? Expanded(
                  child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Suggested coins
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          'Suggested Coins',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                      // Suggested coins items
                      Container(
                        margin: EdgeInsets.all(20),
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: themeNotifier.isDark
                              ? Color.fromARGB(255, 47, 46, 46)
                              : Colors.grey.shade50,
                        ),
                        child: Expanded(
                            child: Column(children: [
                          GestureDetector(
                            onTap: (() => Navigator.pushNamed(
                                context, coindetailRoute,
                                arguments: Arguments(
                                    json.decode(coinsListString[48]), '/'))),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: '${coinsList[48]['image']}',
                                    width: 20,
                                    height: 20,
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation(
                                                Color.fromARGB(
                                                    255, 116, 255, 3))),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          '${coinsList[48]['symbol'].toString().toUpperCase()}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: themeNotifier.isDark
                                                  ? Colors.white
                                                  : Colors.grey.shade700)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text('${coinsList[48]['name']}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: themeNotifier.isDark
                                                  ? Colors.grey.shade500
                                                  : Colors.grey.shade600)),
                                    ],
                                  ),
                                  Expanded(
                                    child: Text(
                                        "#${coinsList[48]['marketCapRank']}",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: themeNotifier.isDark
                                                ? Colors.grey.shade500
                                                : Colors.grey.shade600)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            height: 40,
                            thickness: 2,
                            indent: 0,
                            endIndent: 0,
                            color: themeNotifier.isDark
                                ? Colors.grey.shade700
                                : Colors.grey.shade500,
                          ),
                          GestureDetector(
                            onTap: (() => Navigator.pushNamed(
                                context, coindetailRoute,
                                arguments: Arguments(
                                    json.decode(coinsListString[47]), '/'))),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: '${coinsList[47]['image']}',
                                    width: 20,
                                    height: 20,
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation(
                                                Color.fromARGB(
                                                    255, 116, 255, 3))),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          '${coinsList[47]['symbol'].toString().toUpperCase()}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: themeNotifier.isDark
                                                  ? Colors.white
                                                  : Colors.grey.shade700)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text('${coinsList[47]['name']}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: themeNotifier.isDark
                                                  ? Colors.grey.shade500
                                                  : Colors.grey.shade600)),
                                    ],
                                  ),
                                  Expanded(
                                    child: Text(
                                        "#${coinsList[47]['marketCapRank']}",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: themeNotifier.isDark
                                                ? Colors.grey.shade500
                                                : Colors.grey.shade600)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            height: 40,
                            thickness: 2,
                            indent: 0,
                            endIndent: 0,
                            color: themeNotifier.isDark
                                ? Colors.grey.shade700
                                : Colors.grey.shade500,
                          ),
                          GestureDetector(
                            onTap: (() => Navigator.pushNamed(
                                context, coindetailRoute,
                                arguments: Arguments(
                                    json.decode(coinsListString[46]), '/'))),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: '${coinsList[46]['image']}',
                                    width: 20,
                                    height: 20,
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation(
                                                Color.fromARGB(
                                                    255, 116, 255, 3))),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          '${coinsList[46]['symbol'].toString().toUpperCase()}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: themeNotifier.isDark
                                                  ? Colors.white
                                                  : Colors.grey.shade700)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text('${coinsList[46]['name']}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: themeNotifier.isDark
                                                  ? Colors.grey.shade500
                                                  : Colors.grey.shade600)),
                                    ],
                                  ),
                                  Expanded(
                                    child: Text(
                                        "#${coinsList[46]['marketCapRank']}",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: themeNotifier.isDark
                                                ? Colors.grey.shade500
                                                : Colors.grey.shade600)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ])),
                      ),
                    ],
                  ),
                ))
              : showCircularProgressIndicator
                  ? Container(
                      alignment: Alignment.topCenter,
                      child: CircularProgressIndicator())
                  : Expanded(
                      child: Column(
                        children: [
                          // Coins
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              'Coins',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ),
                          // Coins items
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(20),
                              padding: EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: themeNotifier.isDark
                                    ? Color.fromARGB(255, 47, 46, 46)
                                    : Colors.grey.shade50,
                              ),
                              child: Expanded(
                                  child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: searchedCoinsList.length,
                                      itemBuilder: (context, index) {
                                        return Column(children: [
                                          GestureDetector(
                                            // onTap: (() => Navigator.pushNamed(
                                            //     context, coindetailRoute,
                                            //     arguments: Arguments(
                                            //         json.decode(
                                            //             searchedCoinsListString[
                                            //                 index]),
                                            //         '/'))),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Row(
                                                children: [
                                                  CachedNetworkImage(
                                                    imageUrl:
                                                        '${searchedCoinsList[index]['image']}',
                                                    width: 20,
                                                    height: 20,
                                                    placeholder: (context,
                                                            url) =>
                                                        CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation(
                                                                    Color.fromARGB(
                                                                        255,
                                                                        116,
                                                                        255,
                                                                        3))),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          '${searchedCoinsList[index]['symbol'].toString().toUpperCase()}',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: themeNotifier
                                                                      .isDark
                                                                  ? Colors.white
                                                                  : Colors.grey
                                                                      .shade700)),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                          '${searchedCoinsList[index]['name']}',
                                                          textAlign: TextAlign
                                                              .start,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: themeNotifier
                                                                      .isDark
                                                                  ? Colors.grey
                                                                      .shade500
                                                                  : Colors.grey
                                                                      .shade600)),
                                                    ],
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                        '#${searchedCoinsList[index]['marketCapRank']}',
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: themeNotifier
                                                                    .isDark
                                                                ? Colors.grey
                                                                    .shade500
                                                                : Colors.grey
                                                                    .shade600)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Divider(
                                            height: 40,
                                            thickness: 2,
                                            indent: 0,
                                            endIndent: 0,
                                            color: themeNotifier.isDark
                                                ? Colors.grey.shade700
                                                : Colors.grey.shade500,
                                          ),
                                        ]);
                                      })),
                            ),
                          ),
                        ],
                      ),
                    ),
        ],
      );
    });
  }
}
