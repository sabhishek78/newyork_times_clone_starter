import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newyork_times_clone_starter/news.dart';
import 'list_item.dart';
import 'package:http/http.dart' as http;


void main() => runApp(MaterialApp(
      home: NewsListPage(),
    ));

class NewsListPage extends StatefulWidget {
  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  List<Article> _newsList = new List();
  bool isLoading=true;
  void getData() async {
    isLoading=true;
    http.Response response = await http.get(
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=9da559e0dc0a4b0a9375ca208414ba72");
    setState(() {
      _newsList = News.fromJson(json.decode(response.body)).articles;
       isLoading=false;
    });

  }
  @override
  void initState() {
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    if(isLoading)
      return Scaffold(
        body: Center(
            child:CircularProgressIndicator())
      );
    else
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Abhishek  Times',
          style: TextStyle(
              fontSize: 32, color: Colors.black, fontFamily: 'OldLondon',),
        ),
      ),
      body: Container(
          child: ListView.builder(
            itemCount: _newsList.length,
            itemBuilder: (context, index) => ListItem(_newsList[index]),
          )
      ),
    );
  }
}
