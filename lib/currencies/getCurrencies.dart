import 'dart:async';
import 'dart:convert';
import 'package:crypto_currency_app/app/buying_selling_form.dart';
import 'package:crypto_currency_app/main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class GetCurrencies extends StatefulWidget {
  static String id = '/currenciesScreen';
  final List currencies;
  GetCurrencies({this.currencies});

  @override
  _GetCurrenciesState createState() => _GetCurrenciesState();
}

class _GetCurrenciesState extends State<GetCurrencies> {
  //List Items
  Widget cryptoWidget() {
    return new Container(
      child: new Column(
        children: [
          new Flexible(
            child: new ListView.builder(
              itemCount: widget.currencies.length,
              itemBuilder: (BuildContext context, int index) {
                final Map currency = widget.currencies[index];
                if (widget.currencies[index]['id'] == 1 ||
                    widget.currencies[index]['id'] == 825 ||
                    widget.currencies[index]['id'] == 4687 ||
                    widget.currencies[index]['id'] == 1839 ||
                    widget.currencies[index]['id'] == 1027 ||
                    widget.currencies[index]['id'] == 2 ||
                    widget.currencies[index]['id'] == 3 ||
                    widget.currencies[index]['id'] == 4) {
                  return getListItemUi(currency);
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Card getListItemUi(Map currency) {
    String currencyRate = (currency['quote']['USD']['price']).toString();
    String changeInHour =
        (currency['quote']['USD']['percent_change_1h']).toString();
    return new Card(
      margin: EdgeInsets.only(top: 15, left: 10, right: 10),
      elevation: 10,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color(0xff38B6FF),
          child: Text(
            currency['name'][0],
            style: TextStyle(color: Colors.black),
          ),
        ),
        title: Text(
          currency['name'],
          style: TextStyle(fontFamily: 'Texturina'),
        ),
        subtitle: getSubtitletext(currencyRate, changeInHour),
        isThreeLine: true,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return CurrencyDealingForm(
                  name: currency['name'],
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget getSubtitletext(String priceUSD, String percentageChange) {
    TextSpan priceTextWidget = new TextSpan(
        text: "\$$priceUSD\n", style: TextStyle(color: Colors.black));
    String percentageChangeText = "1 hour: $percentageChange%";
    TextSpan percentageChangeTextWidget;
    if (double.parse(percentageChange) > 0) {
      percentageChangeTextWidget = new TextSpan(
          text: percentageChangeText, style: TextStyle(color: Colors.green));
    } else {
      percentageChangeTextWidget = new TextSpan(
          text: percentageChangeText, style: TextStyle(color: Colors.red));
    }
    return new RichText(
      text: TextSpan(children: [
        priceTextWidget,
        percentageChangeTextWidget,
      ]),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey[100],
              width: double.infinity,
              child: Center(
                child: Text(
                  "Live Prices",
                  style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 35,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              height: 600,
              child: cryptoWidget(),
              color: Colors.white,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.white,
              child: ListView(
                children: [
                  Container(
                    color: Colors.grey[100],
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "Contact for Prices",
                        style: TextStyle(
                          fontFamily: 'Pacifico',
                          fontSize: 35,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                  otherCurrencies(name: 'Web Money'),
                  otherCurrencies(name: 'Ripple'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget otherCurrencies({String name}) {
    return Card(
      margin: EdgeInsets.only(top: 15, left: 10, right: 10),
      elevation: 10,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color(0xff38B6FF),
          child: Text(
            name[0],
            style: TextStyle(color: Colors.black),
          ),
        ),
        title: Text(
          name,
          style: TextStyle(fontFamily: 'Texturina'),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return CurrencyDealingForm(
                  name: name,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
