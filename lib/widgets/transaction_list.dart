import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';


class TransactionList extends StatelessWidget {
  final List<Transaction> transactions ;
  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return  transactions.isEmpty
        ? Column(
      children: [
        Text(
          'No Transactions Added Yet !',
          style: TextStyle(
              color: Theme
                  .of(context)
                  .primaryColor,
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 150,
        ),
        Container(
            height: 200,
            child: Center(
                child: Image.asset('assets/images/money.jpg',
                    fit: BoxFit.cover)))
      ],
    )
      :Container(
      height :500,
      child: ListView.builder(
        itemBuilder: (ctx,index){
          return  Card(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 25,
                    ),
                    decoration:
                    BoxDecoration(
                      shape: BoxShape.circle,
                        border: Border.all(
                          color:Theme.of(context).accentColor,
                          width: 2,
                        )),
                    padding: EdgeInsets.all(30),
                    child: Text(
                      '${transactions[index].price.toStringAsFixed(2)} LE',
                      style: TextStyle(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color:Theme.of(context).accentColor),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transactions[index].title,
                        style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900]),
                      ),
                      Text(
                        DateFormat.yMMMEd().format(transactions[index].date),
                        style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            color: Colors.blueGrey),
                      ),
                    ],
                  )
                ],
              ));
        },
        itemCount: transactions.length,
    ),);
  }
}
