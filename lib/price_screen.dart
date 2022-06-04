import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/material.dart';

Map<String, String> coinValues = {};

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  @override
  String selectedCurrency = 'INR';
  CoinData coinData = CoinData();
  late String BTCprice;
  late String ETHprice;
  late String LTCprice;

  bool isWaiting = true;

  void getPrice() async {
    isWaiting = true;
    try {
      var rate = await coinData.getCoinData(selectedCurrency);
      print(rate['BTC']);
      isWaiting = false;
      setState(() {
        BTCprice = rate['BTC'];
        ETHprice = rate['ETH'];
        LTCprice = rate['LTC'];
      });
    } catch (e) {
      print(e);
    }
  }

  DropdownButton<String> getDropDwonButton() {
    List<DropdownMenuItem<String>> dropDownItem = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownItem.add(newItem);
    }
    return DropdownButton<String>(
        value: selectedCurrency,
        items: dropDownItem,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value!;
            setState(() {
              getPrice();
            });
          });
        });
  }

  @override
  void initState() {
    super.initState();
    getPrice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              my_curriency(
                Price: isWaiting ? '?' : BTCprice,
                selectedCurrency: selectedCurrency,
                currency: 'BTC',
              ),
              my_curriency(
                Price: isWaiting ? '?' : ETHprice,
                selectedCurrency: selectedCurrency,
                currency: 'ETH',
              ),
              my_curriency(
                Price: isWaiting ? '?' : LTCprice,
                selectedCurrency: selectedCurrency,
                currency: 'LTC',
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getDropDwonButton(),
          ),
        ],
      ),
    );
  }
}

class my_curriency extends StatelessWidget {
  const my_curriency({
    required this.Price,
    required this.selectedCurrency,
    required this.currency,
  });

  final String Price;
  final String selectedCurrency;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $currency = $Price $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
