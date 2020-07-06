import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './new_transaction.dart';
import './transaction_list.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> _transactions = [
    Transaction(
        id: '1', title: 'New Shoe', amount: 42.22, date: DateTime.now()),
    Transaction(
        id: '2', title: 'New Jacket', amount: 65.14, date: DateTime.now())
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TransactionList(
          transactions: _transactions,
        ),
        NewTransaction()
      ],
    );
  }
}
