import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List _cartList = [];

  String url =
      "https://notiontech.co.in/demo/book-technician/beta/api/show/cart?customer_id=41";

  Future<void> fetchCart() async {
    final response =
        await get(Uri.parse(url), headers: {'token': 'Booktechnician123'});
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      _cartList = data["data"];
    } else {
      print("unable to fetch api");
    }
  }

  @override
  void initState() {
    super.initState();

    fetchCart();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () {
              setState(() {
                fetchCart();
              });
            },
            child: Text("click to refresh until load the data")),
        FutureBuilder(
            future: fetchCart(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 0, left: 10, right: 10),
                        height: MediaQuery.of(context).size.height * (2.95 / 4),
                        child: ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 5,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                child: Expanded(
                                  child: Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              _cartList[index]["service_name"],
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                                "Price : ${_cartList[index]["price"].toString()}"),
                                            Text(
                                                "Quantity : ${_cartList[index]["quantity"].toString()}"),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                "Rating : ${_cartList[index]["service"]["rating"].toString()}"),
                                            Text(
                                                "Status : ${_cartList[index]["service"]["status"]}"),
                                            Row(
                                              children: [
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      print(
                                                          "******************************************************************");
                                                      var response = await post(
                                                          Uri.parse(
                                                              "https://notiontech.co.in/demo/book-technician/beta/api/add-remove/quantity/cart"),
                                                          body: {
                                                            "cart_id":
                                                                _cartList[index]
                                                                        ["id"]
                                                                    .toString(),
                                                            "status": "Add"
                                                          },
                                                          headers: {
                                                            'token':
                                                                'Booktechnician123'
                                                          });
                                                      print(response.body
                                                          .toString()); // See log to check item added
                                                      setState(() {});
                                                    },
                                                    child: Text("+")),
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      print(
                                                          "******************************************************************");

                                                      var response = await post(
                                                          Uri.parse(
                                                              "https://notiontech.co.in/demo/book-technician/beta/api/add-remove/quantity/cart"),
                                                          body: {
                                                            "cart_id":
                                                                _cartList[index]
                                                                        ["id"]
                                                                    .toString(),
                                                            "status": "Remove"
                                                          },
                                                          headers: {
                                                            'token':
                                                                'Booktechnician123'
                                                          });
                                                      print(response.body
                                                          .toString()); // See log to check item removed
                                                      setState(() {});
                                                    },
                                                    child: Text("-"))
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: _cartList.length,
                        ),
                      ),
                    ],
                  ),
                );
              }
            }),
      ],
    );
  }
}
