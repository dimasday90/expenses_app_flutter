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
      child: Column(
        children: transactions.map((tx) {
          return TransactionCard(
            title: tx.title,
            amount: tx.amount,
            date: tx.date,
          ); //* from './txCard.dart'
        }).toList(),
      ),
    );
  }
}
