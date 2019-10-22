import 'package:newyork_times_clone_starter/news.dart';
import 'package:flutter/material.dart';
import 'news.dart';

class MainScreen extends StatefulWidget {
  final Article article;

  MainScreen(this.article);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String removeSourceFromDescription() {
    List<String> desc = widget.article.description.split("-");
    return desc[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          tooltip: 'Back',
          onPressed: () {Navigator.pop(context);},
        ),
        title: Text(
          'India',
          style: TextStyle(
            fontSize: 32,
            color: Colors.black,
            fontFamily: 'Serif',
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.share),
            color: Colors.black,
            tooltip: 'Share',
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            color: Colors.black,
            tooltip: 'More',
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[Text(
                  widget.article.title??"Unknown",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      fontStyle: FontStyle.italic,
                      color: Colors.black),
                ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(

                    removeSourceFromDescription()??"Unknown",
                    textAlign: TextAlign.left,

                    style: TextStyle(fontStyle: FontStyle.normal, fontSize: 30),
                  ),],
              ),
            ),

            SizedBox(
              height: 15.0,
            ),
            Image.network(widget.article.urlToImage ?? 'https://via.placeholder.com/300'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[SizedBox(
                  height: 15.0,
                ),
                  Text(
                    widget.article.author ?? "Unknown",
                    style: TextStyle(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                        fontSize: 15),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    widget.article.publishedAt ?? "Unknown",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 15.0,
                  )],
              ),
            )
            ,
          ],
        ),
      ),
    );
  }
}