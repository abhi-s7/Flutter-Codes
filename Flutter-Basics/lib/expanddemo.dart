import 'package:flutter/material.dart';

class ExpandDemo extends StatelessWidget {
  _getContainer(var color) {
    return Container(
      width: 100,
      height: 100,
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.only(top: 30),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _getContainer(Colors.blueAccent),
            _getContainer(Colors.greenAccent),
            _getContainer(Colors.orangeAccent),

            /*
            In Expanded Widget mainAxisAlignment will have no sence
            As it will tend to take whole of the spaces available
          */
            //Now they are unproportional
            // Expanded(
            //   //flex: 2,
            //  _getContainer(Colors.blueAccent),
            // ),
            // Expanded(
            //   //flex: 1,
            //   child: _getContainer(Colors.redAccent),
            // ),
            // Expanded(
            //   //flex: 1,
            //   child: _getContainer(Colors.greenAccent),
            // ),
          ],
        ),
      ),
    );
  }
}

/*
To have some widgets make bigger than other widgets
Either make it's height width bigger
Or Use a Expanded Widget
- predefined widget
- accepts a child
- flex: Percentage to space that it will acquire
*/
