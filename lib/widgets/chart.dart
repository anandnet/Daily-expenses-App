import '../widgets/chart_circle.dart';
import "package:flutter/material.dart";
import "package:intl/intl.dart";
class Chart extends StatelessWidget {
  final List recentTransaction;
  Chart(this.recentTransaction);

  List get groupedTransactionList{
    return List.generate(7, (index){
      final weekday=DateTime.now().subtract(Duration(days: index),);
      double totalSum=0;
      for(var i=0;i<recentTransaction.length;i++){
        if(recentTransaction[i].date.day==weekday.day &&
          recentTransaction[i].date.month==weekday.month &&
          recentTransaction[i].date.year==weekday.year){
        totalSum+=recentTransaction[i].amount;
        }
      }
      //print(totalSum.toString()+"total sum");
      return {'day':DateFormat.E().format(weekday).substring(0,1),"amount":totalSum};
    }).reversed.toList();
  }

  double get totalTransaction{
    return groupedTransactionList.fold(0.0, (sum,data){
      //print(data['amount'].toString()+"hjjgjg");
      return sum+(data['amount']);
    });
  }

  @override
  Widget build(BuildContext context) {
    print("$totalTransaction jjj");
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 6,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactionList.map((data){
            return Flexible(
                fit: FlexFit.tight,
                child: ChartCircle(
                data['amount'],
                data["day"],
                totalTransaction==0.0 ? 0.0 : (data['amount']as double)/totalTransaction),
            );
            }).toList(),
        ),
      ),
    );
  }
}