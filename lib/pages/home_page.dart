import 'dart:convert';

import 'package:cryptmark/theme/theme_model.dart';
import 'package:cryptmark/widgets/application_bar.dart';
import 'package:cryptmark/widgets/bottom_navigation_bar.dart';
import 'package:cryptmark/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> test = [];
  Future<void> fetchAPi() async {
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
      var testResponse = jsonDecode(response.body);
      print(testResponse.runtimeType);
      setState(() {
        test = testResponse;
      });

      print(test[4]['id']);
    } else {
      throw Exception('Failed to load weather information.');
    }
  }

  var dummyCoinList = List<DataRow>.generate(20, (i) {
    return DataRow(
      cells: <DataCell>[
        DataCell(Container(
          alignment: Alignment.center,
          child: Text(
            '${i + 1}',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
                fontSize: 11),
          ),
        )),
        DataCell(Container(
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 4,
              ),
              Image.network(
                  'https://assets.coingecko.com/coins/images/1/large/bitcoin.png',
                  width: 20,
                  height: 20),
              const SizedBox(
                height: 4,
              ),
              Text(
                'BTC'.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade900,
                    fontSize: 12),
              ),
            ],
          ),
        )),
        DataCell(Container(
          alignment: Alignment.centerRight,
          child: Text(
            '\$24,161.29',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade900,
                fontSize: 13),
          ),
        )),
        DataCell(Container(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.arrow_drop_up,
                size: 20,
                color: Colors.green,
              ),
              Text(
                '4.7%',
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.green,
                    fontSize: 13),
              ),
            ],
          ),
        )),
        DataCell(Container(
          padding: EdgeInsets.only(right: 20),
          alignment: Alignment.centerRight,
          child: Text(
            '\$462,264,292,650',
            textAlign: TextAlign.right,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade900,
                fontSize: 13),
          ),
        )),
      ],
    );
  });

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAPi();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Cryptmark'),
            automaticallyImplyLeading: false,
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    themeNotifier.isDark
                        ? themeNotifier.isDark = false
                        : themeNotifier.isDark = true;
                  },
                  icon: Icon(themeNotifier.isDark
                      ? Icons.nightlight_rounded
                      : Icons.wb_sunny))
            ],
          ),
          bottomNavigationBar: BottomNavBar(),
          body: Column(
            children: [
              Container(child: SearchBar()),
              SizedBox(
                height: 50,
              ),
              Text(
                'Homepage',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Display prices of 50 cryptocurrencies',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 50,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: DataTable(
                      dataRowHeight: 60,
                      columnSpacing: 0,
                      horizontalMargin: 0,
                      columns: <DataColumn>[
                        DataColumn(
                          label: Container(
                            width: width * .1,
                            child: Text(
                              '#',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade700,
                                  fontSize: 11),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Container(
                            width: width * .1,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Coin'.toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade700,
                                  fontSize: 11),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Container(
                            width: width * .2,
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Price'.toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade700,
                                  fontSize: 11),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Container(
                            width: width * .2,
                            alignment: Alignment.centerRight,
                            child: Text(
                              '24H'.toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade700,
                                  fontSize: 11),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Container(
                            width: width * .4,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Market Cap'.toUpperCase(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade700,
                                      fontSize: 11),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                      // rows: dummyCoinList,
                      rows: List<DataRow>.generate(test.length, (i) {
                        return DataRow(
                          cells: <DataCell>[
                            DataCell(Container(
                              alignment: Alignment.center,
                              child: Text(
                                '${i + 1}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade600,
                                    fontSize: 11),
                              ),
                            )),
                            DataCell(Container(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Image.network('${test[i]['image']}',
                                      width: 20, height: 20),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    '${test[i]['symbol']}'.toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey.shade900,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            )),
                            DataCell(Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '\$${NumberFormat("#,##0.00", "en_US").format(test[i]['current_price'].toDouble())}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade900,
                                    fontSize: 13),
                              ),
                            )),
                            DataCell(Container(
                              alignment: Alignment.centerRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.arrow_drop_up,
                                    size: 20,
                                    color: Colors.green,
                                  ),
                                  Text(
                                    '${test[i]['price_change_percentage_24h_in_currency'].toDouble().toStringAsFixed(1)}%',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green,
                                        fontSize: 13),
                                  ),
                                ],
                              ),
                            )),
                            DataCell(Container(
                              padding: EdgeInsets.only(right: 20),
                              alignment: Alignment.centerRight,
                              child: Text(
                                '\$${NumberFormat('###,###,000').format(test[i]['market_cap'])}',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade900,
                                    fontSize: 13),
                              ),
                            )),
                          ],
                        );
                      })),
                ),
              ),
            ],
          ));
    });
  }
}
