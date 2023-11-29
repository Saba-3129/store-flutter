import 'package:flutter/material.dart';
import 'moudle/appslider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class homeslider extends StatefulWidget {
  @override
  State<homeslider> createState() => _homesliderState();
}

class _homesliderState extends State<homeslider> {
  List<appslider> baners = [];

  int slider_position = 0;

  getsliders() {
    if (baners.length == 0) {
      var url = "http://192.168.1.55/flutter-app/?action=get_sliders";

      http.get(Uri.parse(url)).then((response) {
        print(response.statusCode); //200

        if (response.statusCode == 200) {
          List jsonresponse = convert.jsonDecode(response.body);
          for (int i = 0; i < jsonresponse.length; i++) {
            setState(() {
              baners.add(appslider(img_url: jsonresponse[i]['img_url']));
            });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getsliders();

    return Container(
      child: baners.length > 0
          ? Stack(
              children: [
                PageView.builder(
                  itemBuilder: (context, position) {
                    return slidersView(position);
                  },
                  itemCount: baners.length,
                  onPageChanged: (position) {
                    setState(() {
                      slider_position = position;
                    });
                  },
                ),
                Container(
                  child: Center(child: SLIDER_FOOTER()),
                  margin: EdgeInsets.only(top: 170),
                )
              ],
            )
          : Center(child: CircularProgressIndicator()),
      height: 200,
    );
  }

  Widget slidersView(int position) {
    return Image(
      image: NetworkImage(
          'http://192.168.1.55/flutter-app/' + baners[position].img_url),
      fit: BoxFit.fitWidth,
    );
  }

  Widget SLIDER_FOOTER() {
    List<Widget> SLIDER_FOOTER_ITEM = [];
    for (int i = 0; i < baners.length; i++) {
      i == slider_position
          ? SLIDER_FOOTER_ITEM.add(_Active())
          : SLIDER_FOOTER_ITEM.add(_INActive());
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: SLIDER_FOOTER_ITEM,
    );
  }

  Widget _Active() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      width: 10,
      height: 10,
    );
  }

  Widget _INActive() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      width: 10,
      height: 10,
    );
  }
}
