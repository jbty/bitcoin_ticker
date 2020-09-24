import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CurrencyCard extends StatelessWidget {
  final String cryptoCurrency;
  final String selectedCurrency;
  final String changeValue;
  final Color accentColor;

  CurrencyCard({
    @required this.cryptoCurrency,
    @required this.selectedCurrency,
    @required this.changeValue,
    @required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.0, 7.0, 8.0, 0),
      child: Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Actually 1 $cryptoCurrency is :',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18.0,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '$changeValue',
                    style: TextStyle(
                      fontSize: 55.0,
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    '$selectedCurrency',
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: Icon(
                  Icons.done_all,
                  color: accentColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
