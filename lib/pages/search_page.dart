import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
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
import '../widgets/bottom_navigation_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.searchCoin}) : super(key: key);
  final String searchCoin;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

// TODO: Add search history, save it to shared preferences
// TODO: If search history is empty, add suggested coins section

class _SearchPageState extends State<SearchPage> {
  List<dynamic> search = [];
  late final String coinName;
  late CoinCubit cubit;
  bool _isCoinNameEmpty = true;
  final TextEditingController textController = TextEditingController();
  final String hintText = 'Search for a coin...';

  List<String> coinsSearchHistory = List<String>.generate(
      5,
      (index) =>
          '{"name": "Ethereum", "symbol": "ETH", "image": "https://assets.coingecko.com/coins/images/1/small/bitcoin.png?1547033579", "market_cap_rank": 2}');

  // Get search history from SharedPreferences
  Future<void> getSearchHistoryFromSharedPrefs() async {
    // Create an instance of SharedPreferences
    final prefs = await SharedPreferences.getInstance();

    // Get value of 'searchHistory' key in SharedPreferences
    List<String>? searchHistory = prefs.getStringList('searchHistory');

    // If search history is not null (user has searched for at least a coin)
    if (searchHistory != null) {
      setState(() {
        coinsSearchHistory = searchHistory;
      });
    }
  }

  // Set search history in SharedPreferences
  Future<void> setSearchHistory() async {
    // Create an instance of SharedPreferences
    final prefs = await SharedPreferences.getInstance();

    // Set value of 'searchHistory' key in SharedPreferences
    prefs.setStringList('searchHistory', ['a', 'b', 'c']);
  }

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<CoinCubit>(context)..fetchCoins();
    fetchSearch(coinID: widget.searchCoin);
    // getSearchHistoryFromSharedPrefs();
    textController.addListener(() {
      setState(
        () => _isCoinNameEmpty = textController.text.isEmpty,
      );
    });
  }

  Future<void> fetchSearch({String? coinID}) async {
    final Uri url = Uri(
      scheme: 'https',
      host: 'api.coingecko.com',
      path: 'api/v3/coins/markets',
      queryParameters: {
        'ids': coinID,
        'vs_currency': 'usd',
        'order': 'market_cap_desc',
        'per_page': '50',
        'page': '1',
        'price_change_percentage': '1h,24h,7d',
      },
    );
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var searchResponse = jsonDecode(response.body);
      print(searchResponse.runtimeType);
      setState(() {
        search = searchResponse;
      });
    } else {
      throw Exception('Failed to load search information.');
    }
  }

  searchCoin(String query) {
    cubit.fetchCoins();
  }

  // void filterSearchResults(String query) {
  //   List<String> dummySearchList = List<String>();
  //   dummySearchList.addAll(duplicateItems);
  //   if (query.isNotEmpty) {
  //     List<String> dummyListData = List<String>();
  //     dummySearchList.forEach((item) {
  //       if (item.contains(query)) {
  //         dummyListData.add(item);
  //       }
  //     });
  //     setState(() {
  //       items.clear();
  //       items.addAll(dummyListData);
  //     });
  //     return;
  //   } else {
  //     setState(() {
  //       items.clear();
  //       items.addAll(duplicateItems);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: BottomNavBar(themeNotifier: themeNotifier),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
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
                    searchCoin(value);
                    // Add coin to searchHistory
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
              // Check if coins search history has at least one item
              // If true, display Search History and Suggested Coins
              // Else, display Suggested Coins only
              // Expanded(
              //     child: SingleChildScrollView(
              //   child: Column(
              //     children: [
              //       // Suggested coins
              //       Container(
              //         alignment: Alignment.centerLeft,
              //         padding: EdgeInsets.symmetric(horizontal: 15),
              //         child: Text(
              //           'Suggested Coins',
              //           textAlign: TextAlign.left,
              //           style: TextStyle(
              //               fontSize: 20, fontWeight: FontWeight.w600),
              //         ),
              //       ),
              //       // Suggested coins items
              //       Container(
              //         margin: EdgeInsets.all(20),
              //         padding: EdgeInsets.all(20.0),
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(5),
              //           color: themeNotifier.isDark
              //               ? Color.fromARGB(255, 47, 46, 46)
              //               : Colors.grey.shade50,
              //         ),
              //         child: Expanded(
              //             child: Column(children: [
              //           Container(
              //             padding: EdgeInsets.symmetric(horizontal: 10),
              //             child: Row(
              //               children: [
              //                 CachedNetworkImage(
              //                   imageUrl:
              //                       'https://assets.coingecko.com/coins/images/1/small/bitcoin.png?1547033579',
              //                   width: 20,
              //                   height: 20,
              //                   placeholder: (context, url) =>
              //                       CircularProgressIndicator(
              //                           valueColor: AlwaysStoppedAnimation(
              //                               Color.fromARGB(255, 116, 255, 3))),
              //                   errorWidget: (context, url, error) =>
              //                       Icon(Icons.error),
              //                 ),
              //                 SizedBox(width: 10),
              //                 Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Text("BTC",
              //                         textAlign: TextAlign.start,
              //                         style: TextStyle(
              //                             fontSize: 16,
              //                             fontWeight: FontWeight.w700,
              //                             color: themeNotifier.isDark
              //                                 ? Colors.white
              //                                 : Colors.grey.shade700)),
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text("Bitcoin",
              //                         textAlign: TextAlign.start,
              //                         style: TextStyle(
              //                             fontSize: 16,
              //                             fontWeight: FontWeight.w400,
              //                             color: themeNotifier.isDark
              //                                 ? Colors.grey.shade500
              //                                 : Colors.grey.shade600)),
              //                   ],
              //                 ),
              //                 Expanded(
              //                   child: Text("#1",
              //                       textAlign: TextAlign.right,
              //                       style: TextStyle(
              //                           fontSize: 14,
              //                           fontWeight: FontWeight.w500,
              //                           color: themeNotifier.isDark
              //                               ? Colors.grey.shade500
              //                               : Colors.grey.shade600)),
              //                 ),
              //               ],
              //             ),
              //           ),
              //           Divider(
              //             height: 40,
              //             thickness: 2,
              //             indent: 0,
              //             endIndent: 0,
              //             color: themeNotifier.isDark
              //                 ? Colors.grey.shade700
              //                 : Colors.grey.shade500,
              //           )
              //         ])),
              //       ),
              //     ],
              //   ),
              // ))
              _isCoinNameEmpty
                  ? Container(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: EmptyExplore(),
                    )
                  : Text('not empty')
            ],
          ));
    });
  }
}
