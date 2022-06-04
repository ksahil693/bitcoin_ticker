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

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const ApiKey = '7CC4A724-B5AA-478A-B234-2EF2E50EF1C1';

//url=  rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=$ApiKey

class CoinData {
  Future getCoinData(String coin) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      final url = Uri.parse(
          'https://rest.coinapi.io/v1/exchangerate/$crypto/$coin?apikey=$ApiKey');

      http.Response response = await http.get(url);
      String data = response.body;
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);

        double lastPrice = decodedData['rate'];

        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
