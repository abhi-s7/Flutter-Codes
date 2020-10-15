import 'dart:math';

import 'package:flutter/material.dart';

class MyWidget2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        /*
        setting image through network
        1. 
        child: Image(
          image: AssetImage('src'),
        ),
        2.
        child: Image.asset('images/image.jpg'),

        1.
        child: Image(
          image: NetworkImage('https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.theedgesusu.co.uk%2Fwp-content%2Fuploads%2F2016%2F06%2Fdeadpool-2.jpg&f=1&nofb=1'),
        ),

        2.
        child: Image.network(
            'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.theedgesusu.co.uk%2Fwp-content%2Fuploads%2F2016%2F06%2Fdeadpool-2.jpg&f=1&nofb=1')
        //both ways are corret but this way is shorter

        
        */
        height: media.height,
        width: media.width,
        child: Text(
          'Hi Flutter',
          style: TextStyle(fontSize: 30),
        ),
        // color: Colors.blueAccent,
        /*NOTE::::::::::::::::::::::::::::::::::::::::::::::::::
          
          Don't use color: when using decoration
          To use color: use it in BoxDecoration(color:)

          */

        transform: Matrix4.rotationZ(pi / 6),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: AssetImage('images/image.jpg')),
            //color: Colors.teal,
            //border: Border.all(color: Colors.black, width: 3),
            // borderRadius: BorderRadius.all(
            //   Radius.circular(20),
            // ),
            boxShadow: [
              BoxShadow(color: Colors.blue, blurRadius: 10),
            ]),
      ),
    );
  }
}
