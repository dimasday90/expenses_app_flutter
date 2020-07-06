import 'package:flutter/material.dart';

import './widgets/user_transaction.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expenses App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Expenses App'),
            backgroundColor: Colors.green,
          ),
          body: Container(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.5),
            child: Column(
              children: <Widget>[
                Chart(), //*from './widgets/chart.dart'
                UserTransaction() //*from './widgets/user_transaction.dart'
              ],
            ),
          )),
    );
  }
}
