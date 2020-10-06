import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.label,this.spendingAmount,this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(child: Text('${spendingAmount.toStringAsFixed(0)} LE')),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: [
           Container(
             decoration: BoxDecoration(
               border: Border.all(color:Theme.of(context).primaryColor,width: 1 ),
               color: Colors.grey,
               borderRadius : BorderRadius.circular(10),
             ),
           ),
        FractionallySizedBox(
          heightFactor: spendingPctOfTotal ,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor ,
              borderRadius : BorderRadius.circular(10),
            ),
          ),
        ),
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(label),
      ],
    )
    ;
  }
}
