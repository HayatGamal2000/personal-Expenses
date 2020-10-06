import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {

  _NewTransactionState createState()=> _NewTransactionState();

  final Function _addToList;

  NewTransaction(this._addToList);
}

class _NewTransactionState extends State<NewTransaction>{
  final titleController = TextEditingController();
  final priceController = TextEditingController();

  void submitData(){
    final titleSubmitted = titleController.text;
    final priceSubmitted = double.parse(priceController.text);

    if(titleSubmitted.isEmpty || priceSubmitted <= 0){
      return;
    }
    widget._addToList(
       titleSubmitted,priceSubmitted
    );

    Navigator.of(context).pop();
  }


  @override
  Widget build(BuildContext context) {
     return Card(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          TextField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                labelText: 'Title',
                ),
            controller: titleController,
            onSubmitted: (_)=> submitData (),
          ),
          TextField(
            decoration: InputDecoration(
                labelText: 'price',
                ),
            controller: priceController,
            keyboardType: TextInputType.number,
            onSubmitted: (_)=> submitData (),

          ),
          FlatButton(
            child: Text(
              'Add Transaction',
            ),
            textColor: Theme.of(context).primaryColor,
            onPressed: submitData
          ),
        ]),
      ),
    );

  }
}
