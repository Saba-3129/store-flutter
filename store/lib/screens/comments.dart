import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:store/APPDATA.dart';

class comments extends StatefulWidget {
  List<dynamic> comment_list;
  int product_id;

  comments(this.product_id, this.comment_list);

  @override
  State<comments> createState() => commentview(product_id, comment_list);
}

class commentview extends State<comments> {
  commentview(product_id, List<dynamic> comment_list) {
    if (comment_list.length == 0) {
      String url = AppData.server_url +
          "?action=get_comment&product_id=" +
          product_id.toString();
      http.get(Uri.parse(url)).then((response) {
        if (response.statusCode == 200) {
          setState(() {
            widget.comment_list = convert.jsonDecode(response.body);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, index) {
        return comment_row(index);
      },
      itemCount: widget.comment_list.length,
    );
  }

  Widget comment_row(int index) {
    double W = MediaQuery.of(context).size.width - 30;
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            width: W,
            child:
                Text("commented by :" + widget.comment_list[index]['name']),
            color: Colors.grey[300],
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: W,
            child:
            Text("commented by :" + widget.comment_list[index]['content']),
            color: Colors.grey[300],
          )
        ],
      ),
    );
  }
}
