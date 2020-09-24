import 'dart:io';

import 'package:bitcoin_ticker/components/currency_card.dart';
import 'package:bitcoin_ticker/constants/coin_data.dart';
import 'package:bitcoin_ticker/constants/styles.dart';
import 'package:bitcoin_ticker/services/coin_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinApi _coinApi = CoinApi();
  String _selectedCurrency = "EUR";
  Map<String, String> _allRates = {
    "BTC": "0.0",
    "ETH": "0.0",
    "LTC": "0.0",
  };
  bool _loadingData = true;

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];

    for (String currency in currenciesList) {
      Widget newItem = DropdownMenuItem(
        child: Text(
          currency,
          style: TextStyle(
            color: Colors.grey.shade100,
          ),
        ),
        value: currency,
      );

      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: _selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          _selectedCurrency = value;
          getChangeValue();
        });
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Text> pickerItems = [];

    for (String currency in currenciesList) {
      pickerItems.add(
        Text(
          currency,
          style: TextStyle(
            color: Colors.grey.shade100,
          ),
        ),
      );
    }

    return CupertinoPicker(
      backgroundColor: primaryColor,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          _selectedCurrency = currenciesList[selectedIndex];
          getChangeValue();
        });
      },
      children: pickerItems,
    );
  }

  List<CurrencyCard> cryptoCards() {
    List<CurrencyCard> cardItems = [];

    for (String crypto in cryptoList) {
      cardItems.add(
        CurrencyCard(
          cryptoCurrency: crypto,
          selectedCurrency: _selectedCurrency,
          changeValue: _loadingData ? 'loading...' : _allRates[crypto],
          accentColor: _loadingData || _allRates["BTC"] == "Error"
              ? Colors.redAccent
              : Colors.greenAccent,
        ),
      );
    }

    return cardItems;
  }

  void getChangeValue() async {
    _loadingData = true;

    try {
      var responseBtc =
          await _coinApi.getSpecificRate(_selectedCurrency, "BTC");
      var responseEth =
          await _coinApi.getSpecificRate(_selectedCurrency, "ETH");
      var responseLtc =
          await _coinApi.getSpecificRate(_selectedCurrency, "LTC");

      _loadingData = false;

      setState(() {
        _allRates["BTC"] = responseBtc;
        _allRates["ETH"] = responseEth;
        _allRates["LTC"] = responseLtc;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    getChangeValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Coin Ticker',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 25.0, 10.0, 0),
                child: Text(
                  "Current rate",
                  style: TextStyle(
                    fontSize: 21.0,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: cryptoCards(),
              ),
            ],
          ),
          Container(
            height: 130.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            child: Platform.isIOS ? iosPicker() : androidDropdown(),
            color: primaryColor,
          ),
        ],
      ),
    );
  }
}
