import 'package:flutter/material.dart';
import 'news.dart';
import 'main_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ListItem extends StatelessWidget {
  ListItem(this.article);



  final Article article;
   String calculateArticleTime(){
    var now = new DateTime.now().hour;
    var articleHour=DateTime.parse(article.publishedAt).hour;
    var difference=now-articleHour;
    return "$difference hours ago";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GestureDetector(
          onTap: () async {

            try {


              Navigator.push(
                  (context),
                  MaterialPageRoute(
                      builder: (context) => MainScreen(article)));
            } on Exception catch (e) {
              Alert(
                  context: context,
                  title: "network problem",
                  desc: "Please try after some time")
                  .show();
            }
          },
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                Text(article.title??"Unknown",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,fontFamily: "Serif"),
                ),
                SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(article.description??"Unknown",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        maxLines: 5,
                        style: TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 12,fontFamily: "Serif"),
                      ),
                    ),
                    Container(
                        height: 100,
                        width: 100,
                        child: Image.network(article.urlToImage??
                            'https://via.placeholder.com/300'),
                    ),
                  ],
                ),
                Row(
                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                       flex: 3,
                      child: Row(

                        children: <Widget>[
                          Text(
                            article.author??"Unknown",
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(width: 5,),
                          Text(
                            calculateArticleTime()??"Unknown",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 50,),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.share,
                            color: Colors.grey,
                          ),
                          Icon(
                            Icons.bookmark,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
                Divider(
                  thickness: 2,
                ),
              ],
            ),
          ),
        ),
    );
  }
}


