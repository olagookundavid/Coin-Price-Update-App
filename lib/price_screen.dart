// ignore_for_file: avoid_print
import 'package:btctest/coin_data.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';

String? selectedCurrency = 'AUD';

class Coiner extends StatefulWidget {
  const Coiner({Key? key}) : super(key: key);

  @override
  _CoinerState createState() => _CoinerState();
}

class _CoinerState extends State<Coiner> {
  //implementing drowdown
  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getCurrenciesData();
        });
      },
    );
  }

  /// set the default currency

  bool isWaiting = false;
  String value1 = '.....';
  String value2 = '.....';
  String value3 = '.....';
  String value4 = '.....';
  String value5 = '.....';

  @override
  void initState() {
    super.initState();
    getCurrenciesData();
  }

  getCurrenciesData() async {
    isWaiting = true;
    try {
      Currency currency = Currency();
      double data1 = await currency.getRate('BTC', selectedCurrency);
      double data2 = await currency.getRate('ETH', selectedCurrency);
      double data3 = await currency.getRate('LTC', selectedCurrency);
      double data4 = await currency.getRate('BNB', selectedCurrency);
      double data5 = await currency.getRate('XRP', selectedCurrency);


      isWaiting = false;
      setState(() {
        value1 = data1.toStringAsFixed(0);
        value2 = data2.toStringAsFixed(0);
        value3 = data3.toStringAsFixed(0);
        value4 = data4.toStringAsFixed(0);
        value5 = data5.toStringAsFixed(0);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          'CRYPTO EXCHANGE RATES',
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                cardbuilder('BTC', value1),
                cardbuilder('ETH', value2),
                cardbuilder('LTC', value3),
                cardbuilder('BNB', value4),
                cardbuilder('XRP', value5),
                const SizedBox(
                  height: 80,
                ),
                Container(
                  height: 150.0,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(bottom: 30.0),
                  color: Colors.lightBlue,
                  child: androidDropdown(),
                ),
              ]),
        ],
      ),
    );
  }
}

Padding cardbuilder(String crypto, String value) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
    child: Card(
      color: Colors.blue,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $crypto =  $value $selectedCurrency ',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}
