import 'package:cryptmark/routing/router.dart';
import 'package:cryptmark/theme/theme_model.dart';
import 'package:cryptmark/widgets/application_bar.dart';
import 'package:cryptmark/widgets/bottom_navigation_bar.dart';
import 'package:cryptmark/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var dummyCoinList = List<DataRow>.generate(20, (i) {
    return DataRow(
      cells: <DataCell>[
        DataCell(GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, coindetailRoute,
                arguments: 'Data from home');
          },
          child: Container(
            alignment: Alignment.center,
            child: Text(
              '${i + 1}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,
                  fontSize: 11),
            ),
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
                              ),
                              IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                  icon: Icon(Icons.arrow_drop_up),
                                  color: Colors.grey.shade700,
                                  onPressed: () {}),
                            ],
                          ),
                        ),
                      ),
                    ],
                    rows: dummyCoinList,
                  ),
                ),
              ),
            ],
          ));
    });
  }
}
