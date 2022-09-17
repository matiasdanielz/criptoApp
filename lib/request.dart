import 'dart:convert';
import 'dart:io';
import 'package:cripto_price_cotation/repository/repository.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class updateCoins {
  Future getJson(int i, var url) async {
    var response = await http.get(Uri.parse(url));
    Map<String, dynamic> json = jsonDecode(response.body);
    return json;
  }

  Future<String> getCurrentCoinPrice(int i) async {
    var url =
        'https://www.mercadobitcoin.net/api/' + Coins[i].ticket + '/ticker/';
    var json = await getJson(i, url);
    var price = json['ticker']['last'];
    return price;
  }

  dynamic convertPriceToCurrency(var price) {
    double values = double.parse(price);
    var newFormat = NumberFormat.simpleCurrency(locale: "pt_Br");
    price = newFormat.format(values);
    return price;
  }

  Future setCoinsCurrency() async {
    for (int i = 0; i < Coins.length; i++) {
      var price = await getCurrentCoinPrice(i);
      price = convertPriceToCurrency(price);

      Coins[i].price = price;
    }
  }

  String getLastDay() {
    final int currentYear = DateTime.now().year;
    final int currentMonth = DateTime.now().month;
    int lastDay = DateTime.now().day - 1;
    return '/$currentYear/$currentMonth/$lastDay/'.toString();
  }

  Future getLastOpeningPrice(int i) async {
    var url = 'https://www.mercadobitcoin.net/api/' +
        Coins[i].ticket +
        '/day-summary' +
        getLastDay();

    var json = await getJson(i, url);
    var openingPrice = json['opening'];
    return openingPrice;
  }

  Future setCoinsPercentPriceInDay() async {
    for (int i = 0; i < Coins.length; i++) {
      //current price
      var priceJson = await getCurrentCoinPrice(i);
      double price = double.parse(priceJson);

      //openingPrice
      var lastDayOpeningPrice = await getLastOpeningPrice(i);

      var percentInDay =
          (price - lastDayOpeningPrice) / lastDayOpeningPrice * 100;
      Coins[i].percentInDay = percentInDay.toStringAsFixed(2);
      //Coins[i].percentInDay = -1;
    }
  }
}
