import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cryptmark/states/coin_cubit.dart';
import 'package:cryptmark/states/coin_state.dart';
import 'package:cryptmark/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
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
  List<Map> coinsList = [];

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<CoinCubit>(context);
    // if (cubit.state is CoinLoaded) {
    //   coinsList = cubit.state.coinModel;
    // }
    fetchSearch(coinID: widget.searchCoin);
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
        //'query': widget.searchCoin,
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

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return Scaffold(
          // appBar: AppBar(
          //   title: Text('Search'),
          //   automaticallyImplyLeading: false,
          //   actions: <Widget>[
          //     IconButton(
          //         onPressed: () {
          //           themeNotifier.isDark
          //               ? themeNotifier.isDark = false
          //               : themeNotifier.isDark = true;
          //         },
          //         icon: Icon(themeNotifier.isDark
          //             ? Icons.nightlight_rounded
          //             : Icons.wb_sunny))
          //   ],
          // ),
          bottomNavigationBar: BottomNavBar(themeNotifier: themeNotifier),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: SearchBar(),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Search History',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                // SizedBox(
                //   height: 50,
                // ),
                // Text(
                //   'Searched Coin',
                //   style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // Text(
                //   'Display prices of searched cryptocurrencies',
                //   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                // ),
                // SizedBox(
                //   height: 50,
                // ),
                //   Expanded(
                //     child: SingleChildScrollView(
                //       child: DataTable(
                //           dataRowHeight: 60,
                //           columnSpacing: 0,
                //           horizontalMargin: 0,
                //           columns: <DataColumn>[
                //             DataColumn(
                //               label: Container(
                //                 width: width * .1,
                //                 child: Text(
                //                   '#',
                //                   textAlign: TextAlign.center,
                //                   style: TextStyle(
                //                       fontWeight: FontWeight.bold,
                //                       color: Colors.grey.shade700,
                //                       fontSize: 11),
                //                 ),
                //               ),
                //             ),
                //             DataColumn(
                //               label: Container(
                //                 width: width * .1,
                //                 alignment: Alignment.centerLeft,
                //                 child: Text(
                //                   'Coin'.toUpperCase(),
                //                   style: TextStyle(
                //                       fontWeight: FontWeight.bold,
                //                       color: Colors.grey.shade700,
                //                       fontSize: 11),
                //                 ),
                //               ),
                //             ),
                //             DataColumn(
                //               label: Container(
                //                 width: width * .2,
                //                 alignment: Alignment.centerRight,
                //                 child: Text(
                //                   'Price'.toUpperCase(),
                //                   style: TextStyle(
                //                       fontWeight: FontWeight.bold,
                //                       color: Colors.grey.shade700,
                //                       fontSize: 11),
                //                 ),
                //               ),
                //             ),
                //             DataColumn(
                //               label: Container(
                //                 width: width * .2,
                //                 alignment: Alignment.centerRight,
                //                 child: Text(
                //                   '24H'.toUpperCase(),
                //                   style: TextStyle(
                //                       fontWeight: FontWeight.bold,
                //                       color: Colors.grey.shade700,
                //                       fontSize: 11),
                //                 ),
                //               ),
                //             ),
                //             DataColumn(
                //               label: Container(
                //                 width: width * .4,
                //                 alignment: Alignment.centerRight,
                //                 padding: EdgeInsets.only(right: 20),
                //                 child: Row(
                //                   mainAxisAlignment: MainAxisAlignment.end,
                //                   children: [
                //                     Text(
                //                       'Market Cap'.toUpperCase(),
                //                       style: TextStyle(
                //                           fontWeight: FontWeight.bold,
                //                           color: Colors.grey.shade700,
                //                           fontSize: 11),
                //                     )
                //                   ],
                //                 ),
                //               ),
                //             ),
                //           ],
                //           // rows: dummyCoinList,
                //           rows: List<DataRow>.generate(search.length, (i) {
                //             return DataRow(
                //               cells: <DataCell>[
                //                 DataCell(Container(
                //                   alignment: Alignment.center,
                //                   child: Text(
                //                     '${i + 1}',
                //                     style: TextStyle(
                //                         fontWeight: FontWeight.bold,
                //                         color: Colors.grey.shade600,
                //                         fontSize: 11),
                //                   ),
                //                 )),
                //                 DataCell(Container(
                //                   alignment: Alignment.centerLeft,
                //                   child: Column(
                //                     mainAxisAlignment: MainAxisAlignment.center,
                //                     crossAxisAlignment: CrossAxisAlignment.center,
                //                     children: [
                //                       const SizedBox(
                //                         height: 4,
                //                       ),
                //                       Image.network('${search[i]['image']}',
                //                           width: 20, height: 20),
                //                       const SizedBox(
                //                         height: 4,
                //                       ),
                //                       Text(
                //                         '${search[i]['symbol']}'.toUpperCase(),
                //                         textAlign: TextAlign.center,
                //                         style: TextStyle(
                //                             fontWeight: FontWeight.w500,
                //                             color: Colors.grey.shade900,
                //                             fontSize: 12),
                //                       ),
                //                     ],
                //                   ),
                //                 )),
                //                 DataCell(Container(
                //                   alignment: Alignment.centerRight,
                //                   child: Text(
                //                     '\$${NumberFormat("#,##0.00", "en_US").format(search[i]['current_price'].toDouble())}',
                //                     style: TextStyle(
                //                         fontWeight: FontWeight.w500,
                //                         color: Colors.grey.shade900,
                //                         fontSize: 13),
                //                   ),
                //                 )),
                //                 DataCell(Container(
                //                   alignment: Alignment.centerRight,
                //                   child: Row(
                //                     mainAxisAlignment: MainAxisAlignment.end,
                //                     children: [
                //                       Icon(
                //                         Icons.arrow_drop_up,
                //                         size: 20,
                //                         color: Colors.green,
                //                       ),
                //                       Text(
                //                         '${search[i]['price_change_percentage_24h_in_currency'].toDouble().toStringAsFixed(1)}%',
                //                         textAlign: TextAlign.right,
                //                         style: TextStyle(
                //                             fontWeight: FontWeight.w500,
                //                             color: Colors.green,
                //                             fontSize: 13),
                //                       ),
                //                     ],
                //                   ),
                //                 )),
                //                 DataCell(Container(
                //                   padding: EdgeInsets.only(right: 20),
                //                   alignment: Alignment.centerRight,
                //                   child: Text(
                //                     '\$${NumberFormat('###,###,000').format(search[i]['market_cap'])}',
                //                     textAlign: TextAlign.right,
                //                     style: TextStyle(
                //                         fontWeight: FontWeight.w500,
                //                         color: Colors.grey.shade900,
                //                         fontSize: 13),
                //                   ),
                //                 )),
                //               ],
                //             );
                //           })),
                //     ),
                //   ),
                Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: themeNotifier.isDark
                        ? Color.fromARGB(255, 47, 46, 46)
                        : Colors.grey.shade50,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl:
                                    'https://assets.coingecko.com/coins/images/1/small/bitcoin.png?1547033579',
                                width: 20,
                                height: 20,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation(
                                            Color.fromARGB(255, 116, 255, 3))),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("BTC",
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
                                  Text("Bitcoin",
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
                                child: Text("#1",
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
                        Divider(
                          height: 40,
                          thickness: 2,
                          indent: 0,
                          endIndent: 0,
                          color: themeNotifier.isDark
                              ? Colors.grey.shade700
                              : Colors.grey.shade500,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl:
                                    'https://assets.coingecko.com/coins/images/1/small/bitcoin.png?1547033579',
                                width: 20,
                                height: 20,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation(
                                            Color.fromARGB(255, 116, 255, 3))),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("BTC",
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
                                  Text("Bitcoin",
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
                                child: Text("#1",
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
                        Divider(
                          height: 40,
                          thickness: 2,
                          indent: 0,
                          endIndent: 0,
                          color: themeNotifier.isDark
                              ? Colors.grey.shade700
                              : Colors.grey.shade500,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl:
                                    'https://assets.coingecko.com/coins/images/1/small/bitcoin.png?1547033579',
                                width: 20,
                                height: 20,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation(
                                            Color.fromARGB(255, 116, 255, 3))),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("BTC",
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
                                  Text("Bitcoin",
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
                                child: Text("#1",
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
                      ]),
                ),
                // Suggested Coins
                SizedBox(
                  height: 20,
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Suggested Coins',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ));
    });
  }
}
