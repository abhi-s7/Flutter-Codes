import 'package:flutter/material.dart';

class StackDemo extends StatelessWidget {
  _getContainer(var color, double height, double width) {
    return Container(
      height: height,
      width: width,
      color: color,
    );
  }

  _getBanner(String msg, var lac) {
    //banner is ontop of stack
    return Banner(
      message: msg,
      location: lac,
    );
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Stack Demo'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _getContainer(Colors.amberAccent, 300, 300),
          _getBanner("TOPLEFT", BannerLocation.topStart),
          _getBanner("TOPRIGHT", BannerLocation.topEnd),
          _getBanner("BOTTOMLEFT", BannerLocation.bottomStart),
          _getBanner("BOTTOMRIGHT", BannerLocation.bottomEnd),
          //There banners are useful while showing some text on images like prices or discount on products when making shopping app
          Positioned(
            //positioned will make any widget positioned on some x and y axis
            // It works on Container as well
            bottom: media.height - 150,
            right: media.width - 150,
            child: Icon(
              Icons.phone,
              size: 60,
            ),
          )
//          _getContainer(Colors.green, 200, 200),
//          _getContainer(Colors.blueAccent, 100, 100),
        ],
      ),
    );
  }
}

class StackDemo2 extends StatelessWidget {
  _getContainer(var color, double height, double width) {
    return Container(
      height: height,
      width: width,
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stack Demo'),
      ),
      body: Stack(
        children: <Widget>[
          _getContainer(Colors.redAccent, 300, 300),
          _getContainer(Colors.greenAccent, 200, 200),
          _getContainer(Colors.blue, 100, 100),
          //this will place all of them on top of each other
        ],

        //another attribute
        // fit: StackFit.expand,//this will expand to full screen dimentions
      ),
    );
  }
}
