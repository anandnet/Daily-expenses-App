import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:intl/intl.dart";

class NewTransaction extends StatefulWidget {
  final Function addTxn;
  NewTransaction(this.addTxn);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  DateTime dateChoosed;
  final titleController=TextEditingController();
  final amountController=TextEditingController();

  void submitted(){
    final String title=titleController.text;
    if(amountController.text!=null){

      final double amount=double.parse(amountController.text);

      if(title.isEmpty==false && amount.isNegative==false && dateChoosed!=null){
        widget.addTxn(title,amount,dateChoosed);
        print(titleController.text);
        print(amountController.text);
      }
      else
        return;
    }
    Navigator.of(context).pop();
  }

  void _chooseDate(){
    showDatePicker(context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2019),
    lastDate: DateTime.now()
    ).then((selecteddate){
      if(selecteddate==null){
        return;
      }
      setState(() {
        dateChoosed=selecteddate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
            elevation: 10,
            child:
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[

                  TextField(
                   cursorColor: Colors.purple,
                    decoration: InputDecoration(
                      labelText: "Title"
                    ),
                    controller: titleController,
                    onSubmitted: (_)=>submitted(),
                  ),

                  TextField(
                    cursorColor: Colors.purple,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Amount"
                    ),
                    controller: amountController,
                    onSubmitted: (_)=>submitted(),
                  ),
                  Container(
                    height: 70,
                    child: Row(
                      children: <Widget>[
                        Text(dateChoosed==null ? "No Date Choosen" : DateFormat.yMMMEd().format(dateChoosed)),
                        FlatButton(
                          child: Text("Select Date",style: TextStyle(fontWeight: FontWeight.bold),),
                          textColor: Theme.of(context).primaryColor,
                          onPressed: _chooseDate,
                        ),
                      ],
                    ),
                  ),
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Text("Add Transaction"),
                    onPressed: submitted,
                    textColor: Theme.of(context).textTheme.button.color,
                  )
                ],
              ),
            ),
          );
       }
}