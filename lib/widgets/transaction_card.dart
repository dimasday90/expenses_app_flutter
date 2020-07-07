import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final String title;
  final double amount;
  final DateTime date;

  TransactionCard({this.title, this.amount, this.date});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
              margin: EdgeInsets.symmetric(vertical: 9.0, horizontal: 4.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).primaryColorLight, width: 3.0)),
              child: Text(
                '\$${amount.toStringAsFixed(2)}',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 19),
              )),
          Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              Text(DateFormat.yMd().add_jm().format(date),
                  style: TextStyle(color: Colors.grey))
            ],
          ))
        ],
      ),
    );
  }
}
