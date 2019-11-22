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
  List<Article> _newsList = new List();

  //bool isLoading = true;


  @override
  void initState() {
    super.initState();

  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    print("Page refreshed");
  }

  @override
  Widget build(BuildContext context) {

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
                  //fontFamily: '',
                ),
              ),
              Text(
                "Australia",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                 // fontFamily: 'OldLondon',
                ),
              ),
                  Text(
                    "USA",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      // fontFamily: 'OldLondon',
                    ),
                  ),
                  Text(
                    "NewZeaLand",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      // fontFamily: 'OldLondon',
                    ),
                  ),
                  Text(
                    "Indonesia",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      // fontFamily: 'OldLondon',
                    ),
                  ),
            ]),
          ),
          body: RefreshIndicator(
            child: TabBarView(
              children: <Widget>[
                new NewsList(countryCode: 'in',countryName: 'India'),
                new NewsList(countryCode: 'au',countryName: 'Australia'),
                new NewsList(countryCode: 'us',countryName: 'USA'),
                new NewsList(countryCode: 'nz',countryName: 'NewZeaLand'),
                new NewsList(countryCode: 'id',countryName: 'Indonesia'),
              ],
            ),

            onRefresh: refreshList,
          ),
        ),
      );
  }
}

class NewsList extends StatefulWidget {
  final String countryName;

 final  String countryCode;

  const NewsList({ this.countryName, this.countryCode})  ;
  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  bool isLoading=true;
  @override
  void initState() {
    super.initState();
    getData();
  }

  List<Article> _newsList;

  void getData() async {
    isLoading = true;
    http.Response response = await http.get(
        "https://newsapi.org/v2/top-headlines?country=${widget.countryCode}&apiKey=9da559e0dc0a4b0a9375ca208414ba72");

    setState(() {
      _newsList = News.fromJson(json.decode(response.body)).articles;

      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? Container(
        height: 50.0,
        width: 50.0,
        child:
        Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.black),
              strokeWidth: 5.0),
        )
    ): ListView.builder(
      itemCount: _newsList.length,
      itemBuilder: (context, index) => ListItem(_newsList[index]),
    );
  }
}
