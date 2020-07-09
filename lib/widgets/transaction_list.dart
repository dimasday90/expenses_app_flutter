import 'package:flutter/material.dart';

import './transaction_card.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList({this.transactions, this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.9),
      height: 278,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 9.8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColorDark,
          width: 2.1,
        ),
      ),
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Container(
                  height: 210,
                  margin: EdgeInsets.symmetric(vertical: 8.1),
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.scaleDown,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8.1),
                  child: Text('Transaction is empty',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      )),
                ),
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                return TransactionCard(
                  id: transactions[index].id,
                  title: transactions[index].title,
                  amount: transactions[index].amount,
                  date: transactions[index].date,
                  deleteTransaction: deleteTransaction,
                );
              },
            ),
    );
  }
}
