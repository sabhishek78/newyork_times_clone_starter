import 'package:flutter/material.dart';
import 'news.dart';
import 'main_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
class CustomRectTween extends RectTween {
  CustomRectTween({this.a, this.b}) : super(begin: a, end: b);
  final Rect a;
  final Rect b;

  @override
  Rect lerp(double t) {
    Curves.elasticInOut.transform(t);
    //any curve can be applied here e.g. Curve.elasticOut.transform(t);
    final verticalDist = Cubic(0.72, 0.15, 0.5, 1.23).transform(t);

    final top = lerpDouble(a.top, b.top, t) * (1 - verticalDist);
    return Rect.fromLTRB(
      lerpDouble(a.left, b.left, t),
      top,
      lerpDouble(a.right, b.right, t),
      lerpDouble(a.bottom, b.bottom, t),
    );
  }

  double lerpDouble(num a, num b, double t) {
    if (a == null && b == null) return null;
    a ??= 0.0;
    b ??= 0.0;
    return a + (b - a) * t;
  }
}
class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
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
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ).animate(animation),
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
  String ReadMore(){
     String temp=article.description;
     String returnString='';
     //Text(' [ReadMore..]',style: TextStyle(fontStyle: FontStyle.italic,color: Colors.blue),);
     List<String> tempStringList=temp.split(' ');
     for(int i=0;i<10;i++){
       returnString=returnString+' '+tempStringList[i];
     }
     returnString=returnString+'  '+"[READ MORE...]" ;
     return returnString;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GestureDetector(
          onTap: () async {

            try {


              Navigator.push(context, SlideRightRoute(page: MainScreen(article)));
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
               // SizedBox(height: 10,),
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


