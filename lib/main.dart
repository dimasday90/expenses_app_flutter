import 'package:flutter/material.dart';

import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './widgets/new_transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expenses App',
      theme: ThemeData(
          primarySwatch: Colors.green, accentColor: Colors.greenAccent),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(id: 1, title: 'New Shoe', amount: 42.22, date: DateTime.now()),
    Transaction(id: 2, title: 'New Jacket', amount: 65.14, date: DateTime.now())
  ];

  var idCounter = 2;

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
        id: idCounter + 1,
        title: txTitle,
        amount: txAmount,
        date: DateTime.now());

    setState(() {
      _transactions.add(newTx);
    });
  }

  void _newTransactionModalShow(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: null,
            behavior: HitTestBehavior.opaque,
            child: Container(
              child: NewTransaction(
                addTransactionHandler: _addNewTransaction,
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Expenses App'),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 23.2),
            child: Column(
              children: <Widget>[
                Chart(), //*from './widgets/chart.dart'
                TransactionList(
                  transactions: _transactions,
                ), //*from './widgets/transaction_list.dart'
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _newTransactionModalShow(context),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(17.0))),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
