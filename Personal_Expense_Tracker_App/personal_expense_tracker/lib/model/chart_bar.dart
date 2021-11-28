import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentageOfTheTotalAmount;
  const ChartBar(
      {Key? key,
      required this.spendingAmount,
      required this.label,
      required this.spendingPercentageOfTheTotalAmount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 20,
            child: FittedBox(
              child: Text(
                '\$${spendingAmount.toStringAsFixed(0)}',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 10,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 2,
          ),
          RotatedBox(
            quarterTurns: 2,
            child: Container(
              width: 10,
              height: constraint.maxHeight * 0.6,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueGrey, width: 1.0),
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingPercentageOfTheTotalAmount,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 2,
          ),
          FittedBox(
              child: Text(
            label,
            style:
                TextStyle(color: Theme.of(context).primaryColor, fontSize: 15),
          ))
        ],
      );
    });
  }
}
