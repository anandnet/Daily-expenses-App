import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List transaction;
  final Function deleteTransaction;
  TransactionList(this.transaction,this.deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: transaction.isEmpty ? Column(
        children: <Widget>[
          Text("Oops No transaction done yet",style:  Theme.of(context).textTheme.title),
          SizedBox(height: 20,),
          Container(child: Image.asset("assets/images/waiting.png",fit: BoxFit.cover,),height: 250,),
        ],
      ): ListView.builder(
        itemCount: transaction.length,
        itemBuilder: (context,index){
          return Column(
                      children: [ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  radius:30,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: FittedBox(child: Text(
                        "\$"+transaction[index].amount.toStringAsFixed(1),
                        ),
                    ),
                  ),
                ),
                title: Text(transaction[index].title,style:Theme.of(context).textTheme.title),
                subtitle: Text(DateFormat.yMMMEd().format(transaction[index].date)),
                trailing: IconButton(
                  color: Theme.of(context).errorColor,
                  icon: Icon(Icons.delete),
                  onPressed:()=>deleteTransaction(transaction[index].id),
                  ),
              ),
              Divider(),
            ]
          );
        },
      ),
    );
  }
}