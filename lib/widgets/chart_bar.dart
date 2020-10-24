import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.label,this.spendingAmount,this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder:(ctx , constrains){
      return Column(
        children: [
          Container(
              height: constrains.maxHeight * 0.11,
              child: FittedBox(child: Text(spendingAmount.toStringAsFixed(0)))),
          Container (
              height: constrains.maxHeight * 0.11,
              child: Text('LE')),
          SizedBox(
            height:constrains.maxHeight * 0.06,
          ),
          Container(
            height: constrains.maxHeight * 0.55,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color:Theme.of(context).primaryColor,width: 1 ),
                    color: Colors.grey[400],
                    borderRadius : BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPctOfTotal ,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor ,
                      borderRadius : BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constrains.maxHeight * 0.06,
          ),
          Container(
              height: constrains.maxHeight * 0.11,
              child: Text(label)),
        ],
      );
    });
  }
}
