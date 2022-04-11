// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NGN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const url = '';

class Currency {
  Future getRate(String crypto, String? currency) async {
    http.Response response = await http.get(Uri.parse(
        'https://rest.coinapi.io/v1/exchangerate/$crypto/$currency?apikey=A17E9F4D-752C-4F90-BB61-CD423BF2698C'));
    if (response.statusCode == 200) {
      /// interprets a given string as JSON
      var decodedData = jsonDecode(response.body);
      var rate = decodedData['rate'];
      return rate;
    } else {
      print(response.statusCode);
      throw 'Problem with the get request';
    }
  }
}
