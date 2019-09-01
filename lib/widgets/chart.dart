import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:core';
import 'package:weathy/widgets/chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart({this.recentTransactions});

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      recentTransactions.forEach((transaction) {
        if (transaction.date.day == weekDay.day &&
            transaction.date.month == weekDay.month &&
            transaction.date.year == weekDay.year) {
          totalSum += transaction.amount;
        }
      });

      return {
        'day': DateFormat.E().format(weekDay),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get maxSpending {
    final grouped = groupedTransactionValues;

    return grouped.fold(0.0, (sum, current) {
      return sum + (current['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    // double max = groupedTransactionValues.
    return Card(
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 6),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((group) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: group['day'],
                spendingAmount: group['amount'],
                spendingPctOfTotal: maxSpending != 0
                    ? (group['amount'] as double) / maxSpending
                    : 0,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
