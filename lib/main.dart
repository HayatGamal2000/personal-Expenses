
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
          primaryColor: Colors.blue[900], accentColor: Colors.pinkAccent),
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

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
          Duration(days: 7),),);
    }).toList();
  }

  void _addNewTransaction(String nTitle, double nPrice) {
    final newTrans = Transaction(
        title: nTitle,
        price: nPrice,
        date: DateTime.now(),
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTrans);
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Personal Expenses'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
            ),
            splashColor: Theme
                .of(context)
                .accentColor,
            onPressed: () {
              startAdding(context);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransactions),
            TransactionList(_userTransactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        onPressed: () {
          startAdding(context);
        },
      ),
    );
  }
}
