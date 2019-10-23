import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newyork_times_clone_starter/news.dart';
import 'list_item.dart';
import 'package:http/http.dart' as http;
import 'package:pinch_zoom_image/pinch_zoom_image.dart';

class ImageScreen extends StatefulWidget {
  final String urlToImage;

  ImageScreen(this.urlToImage);

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          // child: Image.network(widget.urlToImage ?? 'https://via.placeholder.com/300'))
          child: PinchZoomImage(
            image: Image.network(
                widget.urlToImage ?? 'https://via.placeholder.com/300'),
            zoomedBackgroundColor: Colors.black,
            hideStatusBarWhileZooming: true,
            onZoomStart: () {
              print('Zoom started');
            },
            onZoomEnd: () {
              print('Zoom finished');
            },
          ),
        ),
      ),
    );
  }
}
