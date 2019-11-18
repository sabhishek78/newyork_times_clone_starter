import 'package:flutter/material.dart';
import 'news.dart';
import 'news_detail.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        FadeTransition(
          opacity: animation,
          child: child,
        ),
  );
}

class ListItem extends StatelessWidget {
 // final RefreshController _refreshController = RefreshController();
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


              Navigator.push(context, FadeRoute(page: NewsDetailScreen(article)));
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,fontFamily: "Serif"),
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
                             fontSize: 15,fontFamily: "Serif"),
                      ),
                    ),
                    SizedBox(width: 2,),
                    Container(
                        height: 150,
                        width: 150,
                      alignment: Alignment(1.0, -1.0),
                        child: Hero(
                          createRectTween: (begin, end)=> RectTween(begin: begin,end: end) ,
                          tag: article.urlToImage,
                          child: Image.network(article.urlToImage??
                              'https://via.placeholder.com/300'),
                        ),
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


