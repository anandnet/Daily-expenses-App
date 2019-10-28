import './widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import "./models/transaction.dart";
import "./widgets/transaction_List.dart";
import './widgets/chart.dart';

void main() => runApp(Home());

class Home extends StatelessWidget{
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Daily Expenses",
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.amber,
        fontFamily: 'ComicSansMs',
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
            fontWeight:FontWeight.bold,
            fontSize: 18,
            fontFamily: "ComicSansMs" ),
          button: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
          title:TextStyle(
            fontFamily: 'Roboto',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          ),
        ),
      ),
      home:HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List <Transaction> _usertransaction=[/*
    Transaction(id: 't1',title: "Shopping",date: DateTime.now(),amount: 34.5),
    Transaction(id: 't2',title: "Study",date: DateTime.now(),amount: 34.5),*/
  ];

  List get _recentTransaction{
    return _usertransaction.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTransaction(String title,double amount,DateTime time){
    final newTx=Transaction(title: title,amount: amount,date: time,id: (DateTime.now()).toString());
    setState(() {
     _usertransaction.add(newTx); 
    });
  }

  void _addNewTransactionSheet(BuildContext ctx){
    print("Hello");
    showModalBottomSheet(context: ctx,
    builder:(_){
      return NewTransaction(_addTransaction);
    },);
  }
  
  void _deleteTransaction(String id){
    setState(() {
     _usertransaction.removeWhere((tx)=>tx.id==id); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Expenses"),
        //backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Column(
                children:[
                  Container(
                    width: double.infinity,
                    child: Chart(_recentTransaction),
                  ),
              TransactionList(_usertransaction,_deleteTransaction),
            ],
          ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=>_addNewTransactionSheet(context),
      ),
  );  
  }
}