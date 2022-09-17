import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class coin {
  var ticket;
  var coin_name;
  var price;
  var percentInDay;
  String image;

  coin({
    required this.ticket,
    required this.coin_name,
    required this.image,
  });
}

List<coin> Coins = [
  coin(ticket: 'BTC', coin_name: 'Bitcoin', image: 'assets/bitcoinLogo.png'),
  coin(ticket: 'ETH', coin_name: 'Ethereum', image: 'assets/ethereumLogo.png'),
  coin(ticket: 'ADA', coin_name: 'Cardano', image: 'assets/cardanoLogo.png'),
  coin(ticket: 'DOT', coin_name: 'Polkadot', image: 'assets/polkadotLogo.png'),
  coin(ticket: 'LTC', coin_name: 'Litecoin', image: 'assets/litecoinLogo.png'),
  coin(ticket: 'SOL', coin_name: 'Solana', image: 'assets/solanaLogo.png'),
];
