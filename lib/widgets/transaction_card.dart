import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/amount.dart';

class TransactionCard extends StatelessWidget {
  final int id;
  final String title;
  final double amount;
  final DateTime date;
  final Function deleteTransaction;

  TransactionCard(
      {this.id, this.title, this.amount, this.date, this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 7,
        horizontal: 4,
      ),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text(Amount(amount, 2).formated,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  )),
            ),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        subtitle: Text(DateFormat.yMMMd().format(date)),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () => deleteTransaction(id),
        ),
      ),
    );
  }
}
