import 'package:flutter/material.dart';
import 'package:store/moudle/Product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:intl/intl.dart';
import 'package:store/sliderview.dart';

import '../moudle/appslider.dart';

import 'package:store/screens/product_screen.dart';

class homepage extends StatefulWidget {
  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  List<Product> new_product = [];
  List<Product> order_product = [];
  List<Widget> sliders = [];

  void getproductlist(String action, List<Product> list) {
    if (list.length == 0) {
      var url = "http://192.168.1.55/flutter-app/?action=" + action;
      // please change ALL the IPs to your system IP//

      http.get(Uri.parse(url)).then((response) {
        print(response.statusCode); //200

        if (response.statusCode == 200) {
          List jsonresponse = convert.jsonDecode(response.body);
          for (int i = 0; i < jsonresponse.length; i++) {
            setState(() {
              list.add(
                new Product(
                    title: jsonresponse[i]['title'],
                    price: int.parse(jsonresponse[i]['price']),
                    img_url: jsonresponse[i]['img_url'],
                    id: int.parse(jsonresponse[i]['id'])),
              );
            });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getproductlist("new_product", new_product);
    getproductlist("order_product", order_product);

    return SingleChildScrollView(
        child: Column(
      children: [
        homeslider(),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(child: Text("Latest Products")),
              Expanded(
                  child: Text(
                "SHOW ALL > ",
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.purple),
              ))
            ],
          ),
        ),
        new_product.length > 0
            ? Container(
                height: 270,
                child: ListView.builder(
                  itemBuilder: newprouductlist,
                  itemCount: new_product.length,
                  scrollDirection: Axis.horizontal,
                ))
            : Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
                height: 270,
              ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(child: Text("Latest Products")),
              Expanded(
                  child: Text(
                "SHOW ALL > ",
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.purple),
              ))
            ],
          ),
        ),
        order_product.length > 0
            ? Container(
                height: 270,
                child: ListView.builder(
                  itemBuilder: orderproductlist,
                  itemCount: order_product.length,
                  scrollDirection: Axis.horizontal,
                ))
            : Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
                height: 200,
              )
      ],
    ));
  }

  Widget newprouductlist(BuildContext context, int index) {
    return indexproductview(index, new_product);
  }

  Widget orderproductlist(BuildContext context, int index) {
    return indexproductview(index, order_product);
  }

  Widget indexproductview(int index, List<Product> list) {
    String price = '';
    String TOMAN = '  TOMAN   ';
    var formater = new NumberFormat('###,###');
    price = formater.format(list[index].price) + TOMAN;
    String title = list[index].title.length > 25
        ? list[index].title.substring(0, 25) + "..."
        : list[index].title;

    return Container(
      margin: EdgeInsets.only(left: 10),
      width: 300,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white24, width: 1),
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          Image(
            image: NetworkImage(
                "http://192.168.1.55/flutter-app/" + list[index].img_url),
            height: 170,
          ),
          GestureDetector(
            child: Text(
              title,
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          productpage(list[index].id, list[index].title)));
            },
          ),
          Divider(
            color: Colors.deepPurple,
            thickness: 3,
          ),
          Container(
            margin: EdgeInsets.only(left: 15, top: 15),
            child: Text(
              price,
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.deepPurple, fontSize: 19),
            ),
            width: 300,
          )
        ],
      ),
    );
  }
}
