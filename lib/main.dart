import 'dart:convert';
import 'dart:ui';
import 'package:assignment/cart_page.dart';
import 'package:assignment/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int bottomIndex = 0;
  List pages = [HomePage(), CartPage()];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("my title"),
        ),
        body: pages[bottomIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: "Cart"),
          ],
          currentIndex: bottomIndex,
          onTap: (index) {
            setState(() {
              bottomIndex = index;
            });
          },
        ),
      ),
    );
  }
}
