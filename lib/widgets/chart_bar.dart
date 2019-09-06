import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar({this.label, this.spendingAmount, this.spendingPctOfTotal});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: <Widget>[
            Container(
              height: constraints.maxHeight * 0.15,
              alignment: Alignment.center,
              child: FittedBox(
                child: Text(spendingAmount.toString()),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.1,
            ),
            Container(
              height: constraints.maxHeight * 0.5,
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
              height: constraints.maxHeight * 0.1,
            ),
            Container(
              child: Text(label.substring(0, 1)),
              height: constraints.maxHeight * 0.15,
            ),
          ],
        );
      },
    );
  }
}
