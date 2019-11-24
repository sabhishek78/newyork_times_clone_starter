import 'package:newyork_times_clone_starter/image_screen.dart';
import 'package:newyork_times_clone_starter/news.dart';
import 'package:flutter/material.dart';
import 'news.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'image_screen.dart';
import 'package:flutter_share/flutter_share.dart';
import 'list_item.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailScreen extends StatefulWidget {
  final Article article;

  NewsDetailScreen(this.article);

  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  String removeSourceFromDescription() {
    List<String> desc = widget.article.title.split("-");
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
  _launchURL() async {
    String url = widget.article.url;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  String displayArticleContent(){
    List<String> temp=widget.article.content.split('[');
    return temp[0];
  }
  String imageCaptionText(){
    List<String> temp=widget.article.content.split('.');
    print(widget.article.content);
    return temp[0];
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
                  removeSourceFromDescription()??"Unknown",
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

                    widget.article.description??"Unknown",
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
                    createRectTween: (begin, end)=> RectTween(begin: begin,end: end) ,
                    tag: widget.article.publishedAt,
                    child: Image.network(widget.article.urlToImage ?? 'https://via.placeholder.com/300'))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[ SizedBox(
                  height: 5.0,
                ),
                  Text(
                    imageCaptionText() ?? "Unknown",
                    style: TextStyle(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                        fontSize: 15),
                  ),
                  SizedBox(
                  height: 15.0,
                ),
                  Text(
                    widget.article.author ?? "Unknown",
                    style: TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontSize: 15),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    calculateArticleTime()??"Unknown",
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    displayArticleContent()??"Unknown",
                    style: TextStyle(
                        color: Colors.black,
                       // fontStyle: FontStyle.ProductSans,
                        fontFamily: 'ProductSans',
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  RaisedButton(
                    padding: const EdgeInsets.all(8.0),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: _launchURL,
                    child: new Text("Read More..."),
                  ),],
              ),
            )
            ,
          ],
        ),
      ),
    );
  }
}
