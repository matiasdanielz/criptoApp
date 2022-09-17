import 'package:cripto_price_cotation/repository/repository.dart';
import 'package:cripto_price_cotation/loadingPage.dart';
import 'dart:async';
import 'package:cripto_price_cotation/request.dart';
import 'package:flutter/material.dart';

class cripto extends StatefulWidget {
  _cripto createState() => _cripto();
}

class _cripto extends State<cripto> {
  updateCoins coin = updateCoins();
  bool isLoading = true;
  int selectedCoin = 0;

  void initState() {
    coin.setCoinsCurrency().then(
      (value) {
        setState(
          () {
            coin.setCoinsPercentPriceInDay();
            coin.setCoinsCurrency();
            Future.delayed(
              const Duration(
                seconds: 3,
              ),
            );
            isLoading = false;
          },
        );
      },
    );

    Timer mytimer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        //code to run on every 5 seconds
        WidgetsBinding.instance.addPostFrameCallback((_) {
          coin.setCoinsPercentPriceInDay().then(
            (value) {
              setState(
                () {
                  coin.setCoinsPercentPriceInDay();
                  coin.setCoinsCurrency();
                },
              );
            },
          );
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingPage()
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Container(
                color: Colors.grey[200],
                child: Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        color: Colors.grey[200],
                        padding: EdgeInsets.symmetric(
                          horizontal: 28.0,
                          vertical: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  Coins[selectedCoin].image,
                                  width: 90,
                                  height: 90,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  Coins[selectedCoin].coin_name,
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Text(
                                'Price',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                            Text(
                              Coins[selectedCoin].price,
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                            Container(
                              width: 60,
                              height: 35,
                              decoration: BoxDecoration(
                                color: double.parse(
                                            Coins[selectedCoin].percentInDay) >
                                        0
                                    ? Colors.green[300]
                                    : Colors.red,
                                borderRadius: BorderRadius.circular(
                                  05,
                                ),
                              ),
                              child: Center(
                                  child: double.parse(Coins[selectedCoin]
                                              .percentInDay) >
                                          0
                                      ? Text(
                                          '+' +
                                              Coins[selectedCoin]
                                                  .percentInDay
                                                  .toString() +
                                              '%',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      : Text(
                                          Coins[selectedCoin]
                                                  .percentInDay
                                                  .toString() +
                                              '%',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 9,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                              45,
                            ),
                            topRight: Radius.circular(
                              45,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28.0,
                            vertical: 28.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Coins',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: Coins.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20.0),
                                      child: MaterialButton(
                                        onPressed: () => setState(() {
                                          selectedCoin = index;
                                        }),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 60,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[100],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    child: Image.asset(
                                                      height: double.infinity,
                                                      width: double.infinity,
                                                      Coins[index].image,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        Coins[index].coin_name,
                                                      ),
                                                      Text(
                                                        Coins[index].ticket,
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Spacer(),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      double.parse(Coins[index]
                                                                  .percentInDay) >
                                                              0
                                                          ? Text(
                                                              '+' +
                                                                  Coins[index]
                                                                      .percentInDay
                                                                      .toString() +
                                                                  '%',
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .green,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            )
                                                          : Text(
                                                              Coins[index]
                                                                      .percentInDay
                                                                      .toString() +
                                                                  '%',
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                color:
                                                                    Colors.red,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        Coins[index].price,
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15.0),
                                              child: Divider(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
