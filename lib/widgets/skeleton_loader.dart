import 'package:flutter/material.dart';

class SkeletonLoader extends StatelessWidget {
  const SkeletonLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return DataTable(
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
                    color: Colors.transparent,
                    fontSize: 11,
                    backgroundColor: Colors.grey),
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
                    color: Colors.transparent,
                    fontSize: 11,
                    backgroundColor: Colors.grey),
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
                    color: Colors.transparent,
                    fontSize: 11,
                    backgroundColor: Colors.grey),
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
                    color: Colors.transparent,
                    fontSize: 11,
                    backgroundColor: Colors.grey),
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
                        color: Colors.transparent,
                        fontSize: 11,
                        backgroundColor: Colors.grey),
                  )
                ],
              ),
            ),
          ),
        ],
        rows: List<DataRow>.generate(5, (i) {
          return DataRow(
            cells: <DataCell>[
              DataCell(Container(
                alignment: Alignment.center,
                child: Text(
                  '${i + 1}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.transparent,
                      fontSize: 11,
                      backgroundColor: Colors.grey),
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
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      'BTC',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.transparent,
                          fontSize: 12,
                          backgroundColor: Colors.grey),
                    ),
                  ],
                ),
              )),
              DataCell(Container(
                alignment: Alignment.centerRight,
                child: Text(
                  '\$24,000.00',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.transparent,
                      fontSize: 13,
                      backgroundColor: Colors.grey),
                ),
              )),
              DataCell(Container(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Icon(Icons.arrow_drop_down, size: 20, color: Colors.red),
                    Container(
                      height: 15,
                      width: 15,
                      color: Colors.grey,
                    ),
                    Text(
                      '2.4%',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.transparent,
                          fontSize: 13,
                          backgroundColor: Colors.grey),
                    ),
                  ],
                ),
              )),
              DataCell(Container(
                padding: EdgeInsets.only(right: 20),
                alignment: Alignment.centerRight,
                child: Text(
                  '\$200,000,000,000',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.transparent,
                      fontSize: 13,
                      backgroundColor: Colors.grey),
                ),
              )),
            ],
          );
        }));
  }
}
