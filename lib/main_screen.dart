import 'package:newyork_times_clone_starter/image_screen.dart';
import 'package:newyork_times_clone_starter/news.dart';
import 'package:flutter/material.dart';
import 'news.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'image_screen.dart';
import 'package:flutter_share/flutter_share.dart';
import 'list_item.dart';

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
  String calculateArticleTime(){
    var now = new DateTime.now().hour;
    var articleHour=DateTime.parse(widget.article.publishedAt).hour;
    var difference=now-articleHour;
    return "$difference hours ago";
  }
  Future<void> share() async {
    await FlutterShare.share(
        title: widget.article.title,
        text: widget.article.description,
        linkUrl: widget.article.url,
        chooserTitle: 'Select App To Share Link',
    );
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
            onPressed: share,
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
            GestureDetector(
                onTap: () async {

                  try {


                    Navigator.push(
                        (context),
                        MaterialPageRoute(
                            builder: (context) => ImageScreen(widget.article.urlToImage)));
                  } on Exception catch (e) {
                    Alert(
                        context: context,
                        title: "network problem",
                        desc: "Please try after some time")
                        .show();
                  }
                },

                child: Hero(
                    createRectTween: (begin, end) {
                      return CustomRectTween(a: begin, b: end);
                    },
                    tag: widget.article.urlToImage,
                    child: Image.network(widget.article.urlToImage ?? 'https://via.placeholder.com/300'))),
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
                    calculateArticleTime()??"Unknown",
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
