import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './widgets/new_transaction.dart';

void main() {
  WidgetsFlutterBinding();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(MyApp());
}

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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _transactions = [];

  int _idCounter = 1;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

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
        isScrollControlled: true,
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

  //# builder methods:

  //* build this widget when the gadget is lanscape oriented
  Widget _buildLandscapePage(
    MediaQueryData mediaQuery,
    AppBar appBar,
    Widget chartWidget,
    BoxDecoration transactionListDecoration,
    Widget transactionListWidget,
  ) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            height: (mediaQuery.size.height -
                    appBar.preferredSize.height -
                    mediaQuery.padding.top) *
                0.76,
            child: chartWidget,
          ),
        ),
        Expanded(
          child: Container(
            height: (mediaQuery.size.height -
                    appBar.preferredSize.height -
                    mediaQuery.padding.top) *
                0.76,
            decoration: transactionListDecoration,
            child: transactionListWidget,
          ),
        ),
      ],
    );
  }

  //* build this widget when the gadget is portrait oriented
  Widget _buildPortraitPage(
    MediaQueryData mediaQuery,
    AppBar appBar,
    Widget chartWidget,
    BoxDecoration transactionListDecoration,
    Widget transactionListWidget,
  ) {
    return Column(
      children: <Widget>[
        Container(
          height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              0.33,
          child: chartWidget,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 8.9),
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 9.8),
          decoration: transactionListDecoration,
          height: (mediaQuery.size.height - appBar.preferredSize.height) * 0.5,
          child: transactionListWidget,
        ),
      ],
    );
  }

  //* run this methods when the platform is iOS

  Widget _buildCupertinoAppBar() {
    return CupertinoNavigationBar(
      middle: Text('Expenses App'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
              onTap: () => _newTransactionModalShow(context),
              child: Icon(CupertinoIcons.add))
        ],
      ),
    );
  }

  Widget _buildCupertinoScaffold(
    ObstructingPreferredSizeWidget appBar,
    Widget pageBody,
  ) {
    return CupertinoPageScaffold(
      navigationBar: appBar,
      child: pageBody,
    );
  }

  //* run this methods when the platform is Android

  Widget _buildMaterialAppBar() {
    return AppBar(
      title: Text('Expenses App'),
    );
  }

  Widget _buildMaterialScaffold(AppBar appBar, Widget pageBody) {
    return Scaffold(
      appBar: appBar,
      body: pageBody,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton.extended(
              label: Text('Add Transaction'),
              icon: Icon(Icons.add),
              onPressed: () => _newTransactionModalShow(context),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(17.0))),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final mainTheme = Theme.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar =
        Platform.isIOS ? _buildCupertinoAppBar() : _buildMaterialAppBar();
    final chartWidget = Chart(
      recentTransactions: _recentTransactions,
    ); //*from '../widgets/chart.dart'
    final transactionListWidget = TransactionList(
      transactions: _transactions,
      deleteTransaction: _deleteTransaction,
    ); //*from '../widgets/transaction_list.dart'
    final transactionListDecoration = BoxDecoration(
      border: Border.all(
        color: mainTheme.primaryColorDark,
        width: 1.5,
      ),
    );
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 23.2),
          child: isLandscape
              ? _buildLandscapePage(
                  mediaQuery,
                  appBar,
                  chartWidget,
                  transactionListDecoration,
                  transactionListWidget,
                )
              : _buildPortraitPage(
                  mediaQuery,
                  appBar,
                  chartWidget,
                  transactionListDecoration,
                  transactionListWidget,
                ),
        ),
      ),
    );

    return Platform.isIOS
        ? _buildCupertinoScaffold(
            appBar,
            pageBody,
          )
        : _buildMaterialScaffold(
            appBar,
            pageBody,
          );
  }
}
