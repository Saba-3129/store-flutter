import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:store/screens/HOME.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'saba'),
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      drawer: Drawer(
          child: Container(
        child: Column(children: [
          ListTile(
            title: Text("LOGIN"),
            onTap: () {
              print("LOGIN");
            },
          ),
          ListTile(
            title: Text("SIGNUP"),
            onTap: () {
              print("SIGNUP");
            },
          ),
        ]),
      )),
      body: homepage(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "MY STORE ",
          style: TextStyle(fontFamily: 'saba'),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart))
        ],
      ),
    ),
  ));
}
