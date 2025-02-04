import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BalanceChart extends StatefulWidget {
  @override
  _BalanceChartState createState() => _BalanceChartState();
}

class _BalanceChartState extends State<BalanceChart> {
  List<Map<String, dynamic>> transactions1 = [
    {'date': 1704067200000, 'balance': 5000}, // 1 Jan 2024
    {'date': 1706745600000, 'balance': 5500}, // 1 Feb 2024
    {'date': 1709251200000, 'balance': 5300}, // 1 Mar 2024
    {'date': 1711929600000, 'balance': 6000}, // 1 Apr 2024
  ];

  List<Map<String, dynamic>> transactions2 = [
    {'date': 1704067200000, 'balance': 3000}, // 1 Jan 2024
    {'date': 1706745600000, 'balance': 4500}, // 1 Feb 2024
    {'date': 1709251200000, 'balance': 4000}, // 1 Mar 2024
    {'date': 1711929600000, 'balance': 5200}, // 1 Apr 2024
  ];

  List<FlSpot> getChartData(List<Map<String, dynamic>> transactions) {
    return transactions.asMap().entries.map((entry) {
      int index = entry.key;
      double balance = entry.value['balance'].toDouble();
      return FlSpot(index.toDouble(), balance);
    }).toList();
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    int index = value.toInt();
    if (index >= 0 && index < transactions1.length) {
      int epochTime = transactions1[index]['date'];
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
          aspectRatio: 1.4,
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0, right: 0.0),
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: leftTitleWidgets,
                      reservedSize: 0,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: bottomTitleWidgets,
                      reservedSize: 0,
                    ),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      //getTitlesWidget: bottomTitleWidgets,
                      reservedSize: 0,
                    ),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      //getTitlesWidget: rightTitleWidgets,
                      reservedSize: 0,
                    ),
                  )
                ),
                borderData: FlBorderData(
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                lineBarsData: [
                  // Original Balance Graph (Blue)
                  LineChartBarData(
                    spots: getChartData(transactions1),
                    isCurved: true,
                    gradient: LinearGradient(colors: [Colors.blue, Colors.blueAccent]),
                    barWidth: 3,
                    belowBarData: BarAreaData(show: false),
                  ),
                  // Second Random Data Set (Red)
                  LineChartBarData(
                    spots: getChartData(transactions2),
                    isCurved: true,
                    gradient: LinearGradient(colors: [Colors.red, Colors.redAccent]),
                    barWidth: 3,
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}


