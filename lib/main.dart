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
        primarySwatch: Colors.green,
        accentColor: Colors.green[700],
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

  var _idCounter = 1;

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime selectedDate) {
    final newTx = Transaction(
      id: _idCounter,
      title: txTitle,
      amount: txAmount,
      date: selectedDate,
    );

    setState(() {
      _idCounter += 1;
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
              padding: EdgeInsets.symmetric(horizontal: 10.1),
              child: NewTransaction(
                addTransactionHandler: _addNewTransaction,
              ),
            ),
          );
        });
  }

  void _deleteTransaction(int id) {
    setState(() {
      _transactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: Text('Expenses App'));
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 23.2),
            child: Column(
              children: <Widget>[
                Container(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.3,
                  child: Chart(
                    recentTransactions: _recentTransactions,
                  ),
                ), //*from '../widgets/chart.dart'
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8.9),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 9.8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColorDark,
                      width: 1.5,
                    ),
                  ),
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height) *
                      0.5,
                  child: TransactionList(
                    transactions: _transactions,
                    deleteTransaction: _deleteTransaction,
                  ),
                ), //*from '../widgets/transaction_list.dart'
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: Text('Add Transaction'),
          icon: Icon(Icons.add),
          onPressed: () => _newTransactionModalShow(context),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(17.0))),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
