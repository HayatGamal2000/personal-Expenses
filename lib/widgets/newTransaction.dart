import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  _NewTransactionState createState() => _NewTransactionState();

  final Function _addToList;

  NewTransaction(this._addToList);
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  DateTime _selectedDate ;

  void _submitData() {
    final titleSubmitted = titleController.text;
    final priceSubmitted = double.parse(priceController.text);

     if( priceController.text.isEmpty){
       return;
     }
    if (titleSubmitted.isEmpty || priceSubmitted <= 0 ||_selectedDate==null) {
      return;
    }
    widget._addToList(titleSubmitted, priceSubmitted,_selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now()).then((pickedDate) {
          if(pickedDate == null ){
            return;
          }
          setState(() {
            _selectedDate = pickedDate;
          });
    });
    print('...');
  }



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          margin: EdgeInsets.only(
            right: 10,
            left: 10,
            top: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom +10,
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                labelText: 'Title',
              ),
              controller: titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'price',
              ),
              controller: priceController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 80,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                        _selectedDate == null?
                        'No Date chosen !'
                    :'picked date : ${DateFormat.yMd().format(_selectedDate)}'
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      'Choose Date',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                    onPressed: _presentDatePicker,
                  )
                ],
              ),
            ),
            RaisedButton(
                child: Text(
                  'Add Transaction',
                ),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: _submitData),
          ]),
        ),
      ),
    );
  }
}
