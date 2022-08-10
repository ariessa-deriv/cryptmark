import 'package:cryptmark/models/coin_model.dart';
import 'package:cryptmark/routing/router.dart';
import 'package:cryptmark/states/coin_cubit.dart';
import 'package:cryptmark/states/coin_state.dart';
import 'dart:convert';

import 'package:cryptmark/theme/theme_model.dart';
import 'package:cryptmark/widgets/application_bar.dart';
import 'package:cryptmark/widgets/bottom_navigation_bar.dart';
import 'package:cryptmark/widgets/search_bar.dart';
import 'package:cryptmark/widgets/skeleton_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    CoinCubit cubit = BlocProvider.of<CoinCubit>(context)..fetchCoins();
    final double width = MediaQuery.of(context).size.width;
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor:
                themeNotifier.isDark ? Colors.grey : Colors.grey.shade100,
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
              BlocBuilder(
                  bloc: cubit,
                  builder: (context, state) {
                    if (state is CoinLoading) {
                      return SkeletonLoader();
                    }

                    if (state is CoinLoaded) {
                      return Expanded(
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
                            rows: List<DataRow>.generate(state.coinModel.length,
                                (i) {
                              return DataRow(
                                cells: <DataCell>[
                                  DataCell(
                                      Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          '${i + 1}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey.shade600,
                                              fontSize: 11),
                                        ),
                                      ), onTap: (() {
                                    Navigator.pushNamed(
                                        context, coindetailRoute,
                                        arguments: state.coinModel[i]);
                                  })),
                                  DataCell(
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Image.network(
                                                '${state.coinModel[i]['image']}',
                                                width: 20,
                                                height: 20),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              '${state.coinModel[i]['symbol']}'
                                                  .toUpperCase(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey.shade900,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ), onTap: (() {
                                    Navigator.pushNamed(
                                        context, coindetailRoute,
                                        arguments: state.coinModel[i]);
                                  })),
                                  DataCell(
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          '\$${NumberFormat("#,##0.00", "en_US").format(state.coinModel[i]['current_price'].toDouble())}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey.shade900,
                                              fontSize: 13),
                                        ),
                                      ), onTap: (() {
                                    Navigator.pushNamed(
                                        context, coindetailRoute,
                                        arguments: state.coinModel[i]);
                                  })),
                                  DataCell(
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            state.coinModel[i][
                                                            'price_change_percentage_24h_in_currency']
                                                        .toDouble() <=
                                                    0
                                                ? Icon(Icons.arrow_drop_down,
                                                    size: 20, color: Colors.red)
                                                : Icon(
                                                    Icons.arrow_drop_up,
                                                    size: 20,
                                                    color: Colors.green,
                                                  ),
                                            Text(
                                              '${state.coinModel[i]['price_change_percentage_24h_in_currency'].toDouble().toStringAsFixed(1)}%',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: state.coinModel[i][
                                                                  'price_change_percentage_24h_in_currency']
                                                              .toDouble() <
                                                          0
                                                      ? Colors.red
                                                      : Colors.green,
                                                  fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ), onTap: (() {
                                    Navigator.pushNamed(
                                        context, coindetailRoute,
                                        arguments: state.coinModel[i]);
                                  })),
                                  DataCell(
                                      Container(
                                        padding: EdgeInsets.only(right: 20),
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          '\$${NumberFormat('###,###,000').format(state.coinModel[i]['market_cap'])}',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey.shade900,
                                              fontSize: 13),
                                        ),
                                      ), onTap: (() {
                                    Navigator.pushNamed(
                                        context, coindetailRoute,
                                        arguments: state.coinModel[i]);
                                  })),
                                ],
                              );
                            })),
                      ));
                    }
                    return Text(state is CoinError
                        ? state.errorMessage
                        : 'Unknown error');
                  }),
            ],
          ));
    });
  }
}
