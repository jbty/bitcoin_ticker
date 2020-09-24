import 'package:bitcoin_ticker/constants/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'screens/price_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: primaryColor,
        cardColor: primaryColor,
        scaffoldBackgroundColor: secondaryColor,
      ),
      home: PriceScreen(),
    );
  }
}
