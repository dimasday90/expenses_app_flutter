import 'package:flutter/material.dart';

import './transaction_card.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList({this.transactions});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.9),
      height: 308,
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 9.8),
      decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).primaryColorDark, width: 2.1)),
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {
          return TransactionCard(
            title: transactions[index].title,
            amount: transactions[index].amount,
            date: transactions[index].date,
          );
        },
      ),
    );
  }
}
