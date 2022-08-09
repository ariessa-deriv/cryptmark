import 'package:cryptmark/widgets/application_bar.dart';
import 'package:cryptmark/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class CoinDetail extends StatefulWidget {
  const CoinDetail({Key? key}) : super(key: key);

  @override
  State<CoinDetail> createState() => _CoinDetailState();
}

class _CoinDetailState extends State<CoinDetail> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
                'https://assets.coingecko.com/coins/images/1/large/bitcoin.png',
                width: 20,
                height: 20),
            SizedBox(width: 20),
            Text("Bitcoin",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.grey.shade700)),
            SizedBox(
              width: 5,
            ),
            Text("(BTC)",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.grey.shade500)),
          ],
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              Icons.star_border_outlined,
              color: Colors.black,
            ),
            onPressed: () {},
          )
        ],
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 40),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20),
            child: Text(
              '\$23,980.00',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20),
            child: SizedBox(
              width: 60,
              height: 30,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.grey.shade200,
                    )),
                child: Row(
                  children: [
                    Icon(Icons.arrow_drop_up, color: Colors.green),
                    Text(
                      '3.1%',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.white),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Market Cap',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade500,
                                fontSize: 15)),
                        Text('\$462,264,292,650',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade700,
                                fontSize: 15))
                      ],
                    ),
                  ),
                  Divider(
                    height: 40,
                    thickness: 2,
                    indent: 0,
                    endIndent: 0,
                    color: Colors.grey.shade300,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Trading Volume',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade500,
                                fontSize: 15)),
                        Text('\$462,264,292,650',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade700,
                                fontSize: 15))
                      ],
                    ),
                  ),
                  Divider(
                    height: 40,
                    thickness: 2,
                    indent: 0,
                    endIndent: 0,
                    color: Colors.grey.shade300,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Circulating Supply',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade500,
                                fontSize: 15)),
                        Text('\$462,264,292,650',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade700,
                                fontSize: 15))
                      ],
                    ),
                  ),
                  Divider(
                    height: 40,
                    thickness: 2,
                    indent: 0,
                    endIndent: 0,
                    color: Colors.grey.shade300,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Supply',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade500,
                                fontSize: 15)),
                        Text('\$462,264,292,650',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade700,
                                fontSize: 15))
                      ],
                    ),
                  ),
                  Divider(
                    height: 40,
                    thickness: 2,
                    indent: 0,
                    endIndent: 0,
                    color: Colors.grey.shade300,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Max Supply',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade500,
                                fontSize: 15)),
                        Text('\$462,264,292,650',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade700,
                                fontSize: 15))
                      ],
                    ),
                  ),
                ]),
          )
        ],
      ),
    );
  }
}
