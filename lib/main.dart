import 'package:cripto_price_cotation/criptoPrice.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(mainScreen());
}

class mainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: cripto(),
    );
  }
}
