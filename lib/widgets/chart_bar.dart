import 'package:flutter/material.dart';

import '../models/amount.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar({this.label, this.spendingAmount, this.spendingPctOfTotal});

  @override
  Widget build(BuildContext context) {
    final mainTheme = Theme.of(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return LayoutBuilder(
      builder: (context, constraints) {
        return isLandscape
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: constraints.maxWidth * 0.10,
                    child: FittedBox(
                      child: Text(
                        Amount(spendingAmount, 1).formated,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.05,
                  ),
                  Container(
                    width: constraints.maxWidth * 0.5,
                    height: 13,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            color: Color.fromRGBO(220, 220, 220, 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        FractionallySizedBox(
                            widthFactor:
                                spendingPctOfTotal > 0 ? spendingPctOfTotal : 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: mainTheme.primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.05,
                  ),
                  Container(
                    width: constraints.maxWidth * 0.15,
                    child: Text(label),
                  ),
                ],
              )
            : Column(
                children: <Widget>[
                  Container(
                    height: constraints.maxHeight * 0.15,
                    child: FittedBox(
                      child: Text(
                        Amount(spendingAmount, 1).formated,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.05,
                  ),
                  Container(
                    height: (constraints.maxHeight * 0.34) + 29,
                    width: 13,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            color: Color.fromRGBO(220, 220, 220, 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        FractionallySizedBox(
                            heightFactor:
                                spendingPctOfTotal > 0 ? spendingPctOfTotal : 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: mainTheme.primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.05,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.15,
                    child: Text(label),
                  ),
                ],
              );
      },
    );
  }
}
