import 'dart:convert';
import 'dart:async';
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
  List<Article> _newsListIndia = new List();
  List<Article> _newsListUSA = new List();
  List<Article> _newsListAustralia = new List();
  List<Article> _newsListNewzealand = new List();
  List<Article> _newsListIndonesia = new List();
  bool isLoading = true;

  void getData() async {
    isLoading = true;
    http.Response responseIndia = await http.get(
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=9da559e0dc0a4b0a9375ca208414ba72");
    http.Response responseUSA = await http.get(
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=9da559e0dc0a4b0a9375ca208414ba72");
    http.Response responseAustralia = await http.get(
        "https://newsapi.org/v2/top-headlines?country=au&apiKey=9da559e0dc0a4b0a9375ca208414ba72");
    http.Response responseNewzealand = await http.get(
        "https://newsapi.org/v2/top-headlines?country=nz&apiKey=9da559e0dc0a4b0a9375ca208414ba72");
    http.Response responseIndonesia = await http.get(
        "https://newsapi.org/v2/top-headlines?country=id&apiKey=9da559e0dc0a4b0a9375ca208414ba72");
    setState(() {
      _newsListIndia = News.fromJson(json.decode(responseIndia.body)).articles;
      _newsListUSA = News.fromJson(json.decode(responseUSA.body)).articles;
      _newsListAustralia = News.fromJson(json.decode(responseAustralia.body)).articles;
      _newsListNewzealand = News.fromJson(json.decode(responseNewzealand.body)).articles;
      _newsListIndonesia = News.fromJson(json.decode(responseIndonesia.body)).articles;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    print("Page refreshed");
    getData();
    //return null;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading)
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    else
      return DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'Abhishek  Times',
              style: TextStyle(
                fontSize: 32,
                color: Colors.black,
                fontFamily: 'OldLondon',
              ),
            ),
            bottom: TabBar(
                isScrollable:true,
                tabs: <Widget>[
              Text(
                "India",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontFamily: '',
                ),
              ),
              Text(
                "Australia",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontFamily: 'OldLondon',
                ),
              ),
              Text(
                "USA",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontFamily: 'OldLondon',
                ),
              ),
              Text(
                "NewZealand",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontFamily: 'OldLondon',
                ),
              ),
              Text(
                "Indonesia",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontFamily: 'OldLondon',
                ),
              ),
            ]),
          ),
          body: RefreshIndicator(
            child: TabBarView(
              children: <Widget>[
                ListView.builder(
                  itemCount: _newsListIndia.length,
                  itemBuilder: (context, index) => ListItem(_newsListIndia[index]),
                ),
                ListView.builder(
                  itemCount: _newsListAustralia.length,
                  itemBuilder: (context, index) => ListItem(_newsListAustralia[index]),
                ),
                ListView.builder(
                  itemCount: _newsListUSA.length,
                  itemBuilder: (context, index) => ListItem(_newsListUSA[index]),
                ),
                ListView.builder(
                  itemCount: _newsListNewzealand.length,
                  itemBuilder: (context, index) => ListItem(_newsListNewzealand[index]),
                ),
                ListView.builder(
                  itemCount: _newsListIndonesia.length,
                  itemBuilder: (context, index) => ListItem(_newsListIndonesia[index]),
                ),
              ],
            ),
            onRefresh: refreshList,
          ),
        ),
      );
  }
}
