import 'dart:convert';

import 'package:assignment/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class BuyPage extends StatefulWidget {
  const BuyPage({super.key});

  @override
  State<BuyPage> createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTotal();

    setState(() {});
  }

  static String cost = "", fees = "", discount = "";

  Future<void> fetchTotal() async {
    final response = await post(
        Uri.parse(
            "https://notiontech.co.in/demo/book-technician/beta/api/cart/total"),
        body: {
          "customer_id": "41",
        },
        headers: {
          'token': 'Booktechnician123'
        });
    Map custTotal = jsonDecode(response.body);
    print(custTotal["data"]["sub_amount"].toString());
    cost = custTotal["data"]["sub_amount"].toString();
    fees = custTotal["data"]["extra_fee"].toString();
    discount = custTotal["data"]["discount"].toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      fetchTotal();
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart",
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 25, right: 25),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Payment",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    Table(
                      children: [
                        TableRow(children: [
                          Container(
                              height: 30,
                              child: Text(
                                "Item Cost : ",
                                style: Constants.headingTextStyle,
                              )),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              cost,
                              style: Constants.headingTextStyle,
                            ),
                          ),
                        ]),
                        TableRow(children: [
                          Container(
                              height: 30,
                              child: Text(
                                "Fess",
                                style: Constants.headingTextStyle,
                              )),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              fees,
                              style: Constants.headingTextStyle,
                            ),
                          ),
                        ]),
                        TableRow(children: [
                          Container(
                              height: 30,
                              child: Text(
                                "Discount",
                                style: Constants.headingTextStyle,
                              )),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              discount,
                              style: Constants.headingTextStyle,
                            ),
                          ),
                        ])
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextButton(
                  onPressed: () {},
                  child: Text("Buy"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder()),
                ),
              ),
            ]),
      ),
    );
  }
}
