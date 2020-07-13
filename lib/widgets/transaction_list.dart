import 'package:flutter/material.dart';

import './transaction_card.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList({this.transactions, this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final curScaleFactor = mediaQuery.textScaleFactor;
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    return LayoutBuilder(
      builder: (ctx, constraints) {
        return transactions.isEmpty
            ? Column(
                children: <Widget>[
                  Container(
                    height: constraints.maxHeight * 0.7,
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
                          fontSize: 19 * curScaleFactor,
                        )),
                  ),
                ],
              )
            : ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (ctx, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    height: isLandscape
                        ? constraints.maxHeight * 0.33
                        : constraints.maxHeight * 0.25,
                    alignment: Alignment.center,
                    child: TransactionCard(
                      id: transactions[index].id,
                      title: transactions[index].title,
                      amount: transactions[index].amount,
                      date: transactions[index].date,
                      deleteTransaction: deleteTransaction,
                    ),
                  );
                },
              );
      },
    );
  }
}
