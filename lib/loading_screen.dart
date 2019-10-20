import 'package:newyork_times_clone_starter/news.dart';
import 'package:flutter/material.dart';
import 'news.dart';


class LoadingScreen extends StatefulWidget {
  final Article article;
  LoadingScreen(this.article);
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(

          child: ListView(
            children: <Widget>[
              Text(
                widget.article.title,

                textAlign: TextAlign.left,

                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40,fontStyle:FontStyle.italic,color: Colors.black),
              ),
              SizedBox( height: 15.0, ),
              Text(
                widget.article.description,

                textAlign: TextAlign.left,

                style: TextStyle(
                    fontStyle: FontStyle.normal, fontSize: 30),
              ),
              SizedBox( height: 15.0, ),
            Image.network(widget.article.urlToImage),
              SizedBox( height: 15.0, ),
              Text(
                widget.article.author,
                style: TextStyle(color: Colors.grey,fontStyle: FontStyle.italic, fontSize: 15),
              ),
              SizedBox( height: 15.0, ),
              Text(
                widget.article.publishedAt,
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox( height: 15.0, ),


            ],
          ),
        ),
      ),
    );
  }
}

