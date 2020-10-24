import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx , constraints){
          return Column(
            children: [
              Text(
                'No Transactions Added Yet !',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.1,
              ),
              Container(
                  height: constraints.maxHeight * 0.7,
                  child: Center(
                      child: Image.asset('assets/images/money.jpg',
                          fit: BoxFit.cover)))
            ],
          );
    })
        : Container(
            height: 500,
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  margin: EdgeInsets.all(10),
                  elevation: 10,
                  child: ListTile(
                    leading: CircleAvatar(
                      foregroundColor: Colors.white,
                      backgroundColor: Theme.of(context).primaryColor,
                      radius: 50,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: FittedBox(
                            child: Text(
                          '${transactions[index].price} LE',
                        )),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMEd().format(transactions[index].date),
                      style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          color: Colors.blueGrey),
                    ),
                    trailing: MediaQuery.of(context).size.width > 450 ?
                        FlatButton.icon(
                          icon: Icon(Icons.delete),
                          label: Text('delete'),
                          textColor: Theme.of(context).errorColor,
                          onPressed: (){deleteTx(transactions[index].id);},
                        )
                        : IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: (){deleteTx(transactions[index].id);},
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
          );
  }
}
