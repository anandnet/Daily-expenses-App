import "package:flutter/material.dart";
class ChartCircle extends StatelessWidget {
  final double dailyExpance,fraction;
  final String day;
  ChartCircle(this.dailyExpance,this.day,this.fraction);
  @override
  Widget build(BuildContext context) {
    print(fraction);
    return Column(
      children: <Widget>[
        Container(
          height: 70,
          width: 40,
          child: Stack(
            children: <Widget>[

              Container(
                decoration: BoxDecoration(
                border: Border.all(color: Colors.grey,width: 2),
                color: Theme.of(context).primaryColorLight,
                borderRadius: BorderRadius.circular(5),
                ),
              ),
              FractionallySizedBox(
                alignment: Alignment.bottomCenter,
                heightFactor: fraction,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Center(child:Text(day,
                style: TextStyle(
                  color: Colors.black45,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  ),
                  )),
            ],
          ),
        ),

        SizedBox(height: 10,),
        Container(
          height: 20,
          child: FittedBox(child: Text(
            "\$"+dailyExpance.toStringAsFixed(0),
            style: TextStyle(fontSize: 15),),
          ),
        ),
      ],
    );
  }
}