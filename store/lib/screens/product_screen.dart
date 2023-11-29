import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:store/screens/comments.dart';
import 'dart:convert' as convert;
import 'commentform.dart';
import 'package:store/APPDATA.dart';

class productpage extends StatefulWidget {
  String title = '';

  int product_id = 1;

  productpage(int id, String title) {
    this.title = title.length > 25 ? title.substring(0, 35) + "..." : title;
    product_id = id;
  }

  @override
  State<productpage> createState() => _productpageState(product_id);
}

class _productpageState extends State<productpage> {
  List<dynamic> comment_list = [];
  String title = "";
  String img_url = "";
  String content = "";

  int tab_index = 0;

  _productpageState(product_id) {
    String url = AppData.server_url +
        "?action=getproductdata&id=" +
        product_id.toString();
    http.get(Uri.parse(url)).then((response) {
      if (response.statusCode == 200) {
        dynamic jsonresponse = convert.jsonDecode(response.body);
        setState(() {
          title = jsonresponse['title'];
          img_url = jsonresponse['img_url'];
          content = jsonresponse['content'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.product_id);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              widget.title,
              style: TextStyle(fontFamily: 'saba'),
            ),
          ),
          body: (_children(tab_index)),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.deepPurple,
            fixedColor: Colors.black,
            backgroundColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.title), label: ('Product Description ')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.comment), label: ('comments')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.image), label: ('Gallery')),
            ],
            onTap: (index) {
              setState(() {
                tab_index = index;
              });
            },
            currentIndex: tab_index,
          ),
        ));
  }

  Widget _children(index) {
    List<Widget> page_screen = [];
    page_screen.add(_tozihat_screnn());
    page_screen.add(_comment_screen());
    page_screen.add(_gallery_screen());
    return page_screen[index];
  }

  Widget _tozihat_screnn() {
    return (!title.isEmpty
        ? SingleChildScrollView(
            child: Column(
              children: [
                Image(image: NetworkImage(AppData.server_url + img_url)),
                Text(title),
                Text(content)
              ],
            ),
          )
        : Container(
            child: Center(child: CircularProgressIndicator()),
          ));
  }

  Widget _comment_screen() {
    /*return new commentform(widget.product_id);*/
 return new comments(widget.product_id,comment_list);

  }

  Widget _gallery_screen() {
    return Container(
      child: Center(
        child: Text('GALLARY'),
      ),
    );
  }
}
