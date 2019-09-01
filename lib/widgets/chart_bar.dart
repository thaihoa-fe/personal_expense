import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar({this.label, this.spendingAmount, this.spendingPctOfTotal});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 20,
          alignment: Alignment.center,
          child: FittedBox(
            child: Text(spendingAmount.toString()),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          height: 80,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPctOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(label),
      ],
    );
  }
}
