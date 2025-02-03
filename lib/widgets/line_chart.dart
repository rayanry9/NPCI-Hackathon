/*
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BalanceChart extends StatefulWidget {
  @override
  _BalanceChartState createState() => _BalanceChartState();
}

class _BalanceChartState extends State<BalanceChart> {
  List<Map<String, dynamic>> transactions = [
    {'date': 1704067200000, 'balance': 5000}, // 1 Jan 2024
    {'date': 1706745600000, 'balance': 5500}, // 1 Feb 2024
    {'date': 1709251200000, 'balance': 5300}, // 1 Mar 2024
    {'date': 1711929600000, 'balance': 6000}, // 1 Apr 2024
  ];

  void addTransaction(int epochTime, double transactionAmount) {
    setState(() {
      // Directly set the balance to the transaction amount (final balance)
      transactions.add({
        'date': epochTime,
        'balance': transactionAmount,
      });
    });
  }

  List<FlSpot> getChartData() {
    return transactions.asMap().entries.map((entry) {
      int index = entry.key;
      double balance = entry.value['balance'].toDouble();
      return FlSpot(index.toDouble(), balance);
    }).toList();
  }

  // This function is called when a transaction occurs
  void onTransactionOccurred(double transactionAmount) {
    int newEpochTime = DateTime.now().millisecondsSinceEpoch;
    addTransaction(newEpochTime, transactionAmount);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1.7,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: false),
              titlesData: FlTitlesData(
                bottomTitles: SideTitles(
                  showTitles: true,
                  getTitles: (value) {
                    int index = value.toInt();
                    if (index >= 0 && index < transactions.length) {
                      int epochTime = transactions[index]['date'];
                      String month = DateFormat('MMM').format(
                        DateTime.fromMillisecondsSinceEpoch(epochTime),
                      );
                      return month;
                    }
                    return '';
                  },
                  reservedSize: 30, // Space for month labels
                ),
                leftTitles: SideTitles(
                  showTitles: true,
                  getTitles: (value) {
                    return value.toString();
                  },
                  margin: 8,
                ),
              ),
              borderData: FlBorderData(show: true),
              lineBarsData: [
                LineChartBarData(
                  spots: getChartData(),
                  isCurved: true,
                  colors: [Colors.blue],
                  barWidth: 3,
                  belowBarData: BarAreaData(show: false),
                ),
              ],
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            double transactionAmount = 6500; // Example transaction amount
            onTransactionOccurred(transactionAmount);
          },
          child: Text("Add Transaction"),
        ),
      ],
    );
  }
}
*/
