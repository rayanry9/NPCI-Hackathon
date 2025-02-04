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

  void onTransactionOccurred(double transactionAmount) {
    int newEpochTime = DateTime.now().millisecondsSinceEpoch;
    addTransaction(newEpochTime, transactionAmount);
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    int index = value.toInt();
    if (index >= 0 && index < transactions.length) {
      int epochTime = transactions[index]['date'];
      String month = DateFormat('MMM').format(
        DateTime.fromMillisecondsSinceEpoch(epochTime),
      );
      return SideTitleWidget(
        meta: meta,
        child: Text(month, style: TextStyle(fontSize: 12)),
      );
    }
    return Container();
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    return Text(value.toStringAsFixed(0), style: TextStyle(fontSize: 12));
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
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: leftTitleWidgets,
                    reservedSize: 40,
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: bottomTitleWidgets,
                    reservedSize: 30,
                  ),
                ),
              ),
              borderData: FlBorderData(
                border: Border.all(color: Colors.grey, width: 1),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: getChartData(),
                  isCurved: true,
                  gradient: LinearGradient(colors: [Colors.blue, Colors.blueAccent]),
                  barWidth: 3,
                  belowBarData: BarAreaData(show: false),
                ),
              ],
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            double transactionAmount = 6500;
            onTransactionOccurred(transactionAmount);
          },
          child: Text("Add Transaction"),
        ),
      ],
    );
  }
}

