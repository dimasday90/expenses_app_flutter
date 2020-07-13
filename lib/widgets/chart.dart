import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart({this.recentTransactions});

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;

      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (acc, item) {
      return acc + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: EdgeInsets.all(5.0),
          child: Card(
            elevation: 6,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  if (isLandscape)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: groupedTransactionValues.map((tx) {
                        return Container(
                          width: constraints.maxWidth,
                          child: ChartBar(
                            label: tx['day'],
                            spendingAmount: tx['amount'],
                            spendingPctOfTotal:
                                (tx['amount'] as double) / totalSpending,
                          ),
                        );
                      }).toList(),
                    ),
                  if (!isLandscape)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: groupedTransactionValues.map((tx) {
                        return Container(
                          height: constraints.maxHeight * 0.7,
                          child: ChartBar(
                            label: tx['day'],
                            spendingAmount: tx['amount'],
                            spendingPctOfTotal:
                                (tx['amount'] as double) / totalSpending,
                          ),
                        );
                      }).toList(),
                    ),
                  SizedBox(
                    height: constraints.maxHeight * 0.01,
                  ),
                  FittedBox(
                    child: Text(
                      'Last Week Chart',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
