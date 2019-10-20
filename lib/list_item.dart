import 'package:flutter/material.dart';
import 'news.dart';
import 'loading_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ListItem extends StatelessWidget {
  ListItem(this.article);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GestureDetector(
          onTap: () async {
            try {
              // Position postion =await getLocation();

              //Map result=await fetchWeatherInfo(position);

              Navigator.push(
                  (context),
                  MaterialPageRoute(
                      builder: (context) => LoadingScreen(article)));
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
                Text(
                  article.title,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        article.description,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        maxLines: 5,
                        style: TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 12),
                      ),
                    ),
                    Container(
                        height: 100,
                        width: 100,
                        child: Image.network(article.urlToImage)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(

                      children: <Widget>[
                        Text(
                          article.author.substring(0,5),
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(width: 5,),
                        Text(
                          article.publishedAt,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    Row(
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
                    /*
                    Expanded(

                      child: Text(
                        article.author,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(width: 2,),
                    Expanded(

                      child: Text(
                        article.publishedAt,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(width: 5,),
                    Icon(
                      Icons.share,
                      color: Colors.grey,
                    ),
                    Icon(
                      Icons.bookmark,
                      color: Colors.grey,
                    ),
                    */
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


