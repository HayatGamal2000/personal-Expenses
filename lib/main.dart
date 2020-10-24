import 'package:flutter/cupertino.dart';

import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';
import 'package:flutter/material.dart';
import './widgets/newTransaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primaryColor: Colors.blue[900],
        accentColor: Colors.pink[300],
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    //Transaction(
    //id: 't1',
    //title: 'New Shoes',
    //price: 190.99,
    //date: DateTime.now(),
    //),
    //Transaction(
    //id: 't2',
    //title: 'New bag',
    //price: 320.55,
    //date: DateTime.now(),
    //),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String nTitle, double nPrice, DateTime chosenDate) {
    final newTrans = Transaction(
        title: nTitle,
        price: nPrice,
        date: chosenDate,
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTrans);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  void startAdding(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      centerTitle: true,
      title: Text('Personal Expenses'),
      actions: [
        IconButton(
          icon: Icon(
            Icons.add,
          ),
          splashColor: Theme.of(context).accentColor,
          onPressed: () {
            startAdding(context);
          },
        )
      ],
    );
    final mediaQuery = MediaQuery.of(context);
    final _isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final txListWidget =Container(
        height: (mediaQuery.size.height -
            appBar.preferredSize.height -
            mediaQuery.padding.top) *
            0.68,
        child:
        TransactionList(_userTransactions, _deleteTransaction));

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if(_isLandScape)Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Show Chart'),
                Switch(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    })
              ],
            ),
            if(!_isLandScape)Container(
              height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
                  0.3,
              child: Chart(_recentTransactions),
            ),
            if(!_isLandScape)txListWidget,
            if(_isLandScape)
            _showChart
                ? Container(
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                        0.7,
                    child: Chart(_recentTransactions),
                  )
                : txListWidget,
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          startAdding(context);
        },
      ),
    );
  }
}
