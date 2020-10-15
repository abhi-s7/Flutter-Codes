import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../screens/login.dart';

import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _moveToNextScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    /*
    Navigator is the method to Navigate to the some other screen
    First argument is the context - which represent the current screen which is simialr to this in a class{that represent the current obj}
    Second Argumnet is MPR which is responsible for the Navigation
    It has a builder that expects an context to the next screen
    
    Navigator - it keeps a stack of screens
    current location is given by context(this is global one)
    route - where to go

    it automatically give back button in other screen where we are sending it

    */
  }

  _loadAndMove() {
    Timer(Duration(seconds: 5), () => _moveToNextScreen());
    //This comes from 'dart:async'
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadAndMove();
    /*
    When the screen loads up for the first time initState is called
    which will call the _loadAndMove method
    _loadAndMove contains a Timer which will run it's call back after the time specified
    In it's call back we have specified _moveToNextScreen which will Navigate to Login Screen
    */

    //widget -> object created -> Constructor called -> initState -> Build
    //so this will call again every time the screen is loaded

    /*
    its a life cycle functions as it is called automatically
    It is only called once when the app is called
    */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        //this starts from below the notification bar
        child: Stack(
          //this will put children on top of one another
          children: [
            Container(
              //Container takes the size of content that it has
              //i.e. if I make child: Text() it will just shrink to its size
              //Therefore use media.width and media.height to make it full screen

              //child: Text('This is splash Screen'),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.black,
                  Colors.teal,
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                //this will align the colors from topleft to bottomRight
                //by default it is like vertical line of colors from top to bottom
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //this will hold the image and company name to be displayed
                children: [
                  Image.network(Constants.SPLASH_IMG_URL),
                  Text(
                    "Music App 2020",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.orangeAccent,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ), //to make some space
                  Text(
                    'All CopyRight Reserved',
                    style: TextStyle(
                      color: Colors.black45,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: RaisedButton(
                      disabledColor: Colors.grey[400],
                      color: Colors.teal,
                      onPressed: () {
                        _moveToNextScreen();
                        /*
                        NOTE:::: If you are passing a non-null or don't even specify onPressed property
                        Raised button color will be of disabledColor either we can specify so or it would be by default of Materail app's color
                        */
                      },
                      child: Text('Explore',
                          style: TextStyle(color: Colors.grey[200])),
                      elevation: 10,
                      padding: EdgeInsets.all(20),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
