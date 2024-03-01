import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    fetchPosts();
  }

  List _items = [];
  String url =
      "https://notiontech.info/demo/book-technician/beta/api/show/service-list?customer_id=41&category_id=11";

  Future<void> fetchPosts() async {
    try {
      final response =
          await get(Uri.parse(url), headers: {'token': 'Booktechnician123'});
      final data = jsonDecode(response.body); // loads string

      _items = data["data"];

      setState(() {
        fetchPosts();
      });

      for (int i = 0; i < _items.length; i++) {
        print("item :  ${_items[i]["id"]}");
        print("service name :  ${_items[i]["name"]}");
      }
    } catch (err) {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    fetchPosts();
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ElevatedButton(
              onPressed: () {
                setState(() {
                  fetchPosts();
                });
              },
              child: Text("click to refresh")),
          Container(
            height: 1000,
            padding: EdgeInsets.only(bottom: 100),
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.all(20),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: 120,
                    child: Expanded(
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${_items[index]["name"]}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${_items[index]["service_category_name"]}",
                                  style: TextStyle(fontSize: 14),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Rs. ${_items[index]["discounted_price"]} ",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      " ${_items[index]["original_price"]} ",
                                      style: TextStyle(
                                          fontSize: 10,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: const Color.fromARGB(
                                              255, 37, 25, 25),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Image.asset(
                                    "images/images.png",
                                    height: 40,
                                    width: 40,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    post(
                                        Uri.parse(
                                            "https://notiontech.info/demo/book-technician/beta/api/add/cart"),
                                        body: {
                                          "service_id": _items[index]["terms"]
                                                  [0]["service_id"]
                                              .toString(),
                                          "customer_id": "41"
                                        },
                                        headers: {
                                          'token': 'Booktechnician123'
                                        });
                                  },
                                  child: Text(
                                    "Add to Cart",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // child: Text(
                    //   "${"item :  ${_items[index]["name"]}"}",
                    //   // "asdf",
                    //   style: TextStyle(color: Colors.black),
                    // ),
                  ),
                );
              },
              itemCount: _items.length,
            ),
          ),
        ],
      ),
    );
  }
}
