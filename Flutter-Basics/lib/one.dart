/*
Stateless widgets doesn't change their state during
the execution of the program
//data cannot be change on runtime
write stless for stateless widget

While stfull is modifiable
it keep changing the state
i.e. Mutable
 */

/*
build - function responsible to design the content
GUI

BuildContext tells the position of widget in the widget tree

Scaffold - widget to layout other widget

Container - BoxDecoration
by default it have heigth and width of parent
but when we specify any child it takes the size of child
 */

import 'dart:math';

import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size; //this gives the device size
    return Scaffold(
      //Scaffold is like a page for layouting your application
      appBar: AppBar(
        /*
        leading: Gives the leading icon
        actions:<Widget>[<List of icons>]
        */
        leading: Icon(
          Icons.apps,
          color: Colors.black,
        ),
        title: Text('App bar', style: TextStyle(fontSize: 30)),
        actions: <Widget>[
          Icon(Icons.email),
          Padding(
            padding: EdgeInsets.only(right: 10, left: 10),
            child: Icon(Icons.message),
          )
        ],
      ),
      body: Container(
        //for full length height and width
        height: double.infinity, //same as media.height
        width: double.infinity, //media.width
        //margin: EdgeInsets.all(120.0),
        //bad practice therefore use MediaQuery
        // margin: EdgeInsets.only(top: media.height/2, left: media.width/2),
        // //media.height - device height
        // padding: EdgeInsets.all(30),

        //to transform
        transform: Matrix4.rotationZ(
            pi / 6), //this will rotate the box //used in designing
        //pi is coming from dart:math
        decoration: BoxDecoration(
          // gradient: SweepGradient(
          //   colors: [
          //     Colors.redAccent,
          //     Colors.blueAccent,
          //     Colors.amberAccent,
          //     Colors.blueAccent
          //   ],
          // ),
          //similarly LinearGradient
          // gradient: RadialGradient(
          //   stops:[0.5,0.10]//this will stop the colors after some percentage
          //   colors: [Colors.redAccent, Colors.greenAccent, Colors.blueAccent]
          // ),
          //gradient is mix of colors

          color: Colors.greenAccent,

          /*NOTE::::::::::::::::::::::::::::::::::::::::::::::::::
          
          BY using shape: if BoxShape.cirle then don't ever use borderRadius
          As it will give error because it expects either one of them to be non existing


          */

          //shape: BoxShape.circle, //makes a circle shape of box
          //this will also rotate the image
          image: DecorationImage(
              image: NetworkImage(
                  'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.theedgesusu.co.uk%2Fwp-content%2Fuploads%2F2016%2F06%2Fdeadpool-2.jpg&f=1&nofb=1')),
          border: Border.all(color: Colors.black, width: 3),
          borderRadius: BorderRadius.all(Radius.circular(20)),

          boxShadow: [BoxShadow(color: Colors.blue, blurRadius: 10)],
        ),

        child: Text(
          'Hi Flutter',
          style: TextStyle(fontSize: 30),
        ),
        //set image through network
        //child: Image.network('https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fdesignlike.com%2Fwp-content%2Fuploads%2F2015%2F09%2Fgoogle-office.jpg&f=1&nofb=1'),
        // child: Image(
        //   image: AssetImage('images/image.png'),
        // ),

        //color: Colors.amberAccent,
        //don't use this if color is specified in BoxDecoratin
      ),
    );
  }
}
