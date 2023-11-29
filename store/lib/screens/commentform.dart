import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../APPDATA.dart';

class commentform extends StatefulWidget {
  int product_id;

  commentform(this.product_id);

  @override
  State<commentform> createState() => _commentformState();
}

class _commentformState extends State<commentform> {
  int send = 0;
  String _name = "";
  String _email = "";
  String _comment = "";
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        onSaved: (value) {
                          _name = value!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'لطفا نام ونام خاتوادگی خود را وارد نمایید';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.purple,
                            ),
                            labelText: 'نام و نام خانوادگی',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        onSaved: (value) {
                          _email = value!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'لطفا ایمیل خود را وارد نمایید';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.purple,
                            ),
                            labelText: 'ایمیل',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        onSaved: (value) {
                          _comment = value!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'لطفا نظر خود را وارد نمایید';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        minLines: 5,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.comment,
                              color: Colors.purple,
                            ),
                            labelText: 'نظر',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)))),
                      ),
                    ),
                    ButtonTheme(
                      height: 50,
                      minWidth: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              //send comment

                              _formkey.currentState!.save();

                              setState(() {
                                send = 1;
                              });

                              _send_comment_data();
                            }
                          },
                          child: Text("ثبت نظر "),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.deepPurple)),
                    )
                  ],
                )),
          )),
        ),
        send == 1
            ? Opacity(
                opacity: 0.3,
                child: Container(
                  color: Colors.white,
                  child: Center(child: CircularProgressIndicator()),
                ),
              )
            : Text('')
      ],
    );
  }

  _send_comment_data() {
    String url = AppData.server_url +
        "?action=add_comment&prouduct_id=" +
        widget.product_id.toString();
    http.post(Uri.parse(url), body: {
      "name": _name,
      "email": _email,
      "comment": _comment
    }).then((response) {
      print(response.body);

      setState(() {
        send = 0;
        _formkey.currentState!.reset();
      });
    });
  }
}
