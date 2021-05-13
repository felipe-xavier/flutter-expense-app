import 'package:expenses_app/widgets/chart_bar.dart';

import '../models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  final int chartSize = 7;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    final today = DateTime.now();
    final List<DateTime> weekDays =
        List.generate(chartSize, (id) => today.subtract(Duration(days: id)));
    final Map<String, double> weekDaysTotal = Map.fromIterables(
      weekDays.map((e) => DateFormat.yMd().format(e)),
      List<double>.filled(chartSize, 0),
    );

    for (var txn in recentTransactions) {
      if (txn.date.isAfter(today.subtract(Duration(days: chartSize)))) {
        weekDaysTotal[DateFormat.yMd().format(txn.date)] += txn.amount;
      }
    }

    print(weekDaysTotal);

    return List.generate(chartSize, (index) {
      final weekDay = today.subtract(Duration(days: index));

      return {
        'day': DateFormat.E().format(weekDay),
        'amount': weekDaysTotal[DateFormat.yMd().format(weekDay)],
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTransactionValues.fold(0.0, (sum, txn) {
      return sum + txn['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactionValues.map((group) {
            return Expanded(
              child: ChartBar(
                group['day'],
                group['amount'],
                maxSpending == 0.0
                    ? 0.0
                    : (group['amount'] as double) / maxSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
