import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:teamupadmin/Utils/CheckInternet.dart';

class ShowNetworkImage extends StatefulWidget {
  String imageUrl;

  ShowNetworkImage(this.imageUrl);

  @override
  _ShowNetworkImageState createState() => _ShowNetworkImageState();
}

class _ShowNetworkImageState extends State<ShowNetworkImage> {
  CheckInternet checkInternet;
  bool isInternetAvailable = false;

  @override
  void initState() {
    super.initState();
    checkInternet = new CheckInternet();
    checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
        });
      } else {
        setState(() {
          isInternetAvailable = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Image Preview'),
        ),
        body: isInternetAvailable
            ? Container(
                child: Center(
                  // child: Image.memory(),
                 child: Hero(
                    tag: 'Image Preview',
                      child: Image.network(widget.imageUrl)),
                ),
              )
            : Container(
                child: Center(
                  child: Text('Please check your internet connection..'),
                ),
              ));
  }
}
