import 'dart:convert';
import 'dart:io';

import 'package:estate_agent/constants.dart';
import 'package:flutter/material.dart';

class ListHouseScreen extends StatefulWidget {
  @override
  _ListHouseScreenState createState() => _ListHouseScreenState();
}

class _ListHouseScreenState extends State<ListHouseScreen> {

  String url;
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    url = "$BaseUrl/houses";
    getHousesList(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Houses's List")),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: (){

              }
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: BLUE_ACCENT,
            textTheme: Theme
                .of(context)
                .textTheme
                .copyWith(caption: new TextStyle(color: Colors.grey))),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('List houses'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_comment),
              title: Text('Add house'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profil'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<String> getHousesList(String url) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    HttpClientRequest request = await client.getUrl(Uri.parse("$url"));
    request.headers.set('Accept', 'application/json');
    //request.headers.set('Authorization', 'Bearer $_token');
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    print("url: $url");
    print("reply: $reply");
    print("status: ${response.statusCode}");
    if(response.statusCode == 200){

    }
  }
}
