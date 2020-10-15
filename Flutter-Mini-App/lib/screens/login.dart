import 'package:flutter/material.dart';
import 'package:music_app/screens/music.dart';
import '../utils/constants.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  _createTextFields({bool isPwd, var iconObj, String hintText, String label}) {
    return Container(
      //margin: EdgeInsets.only(top: 30),
      child: TextField(
        obscureText: isPwd,
        style: TextStyle(fontSize: 25, color: Colors.black),
        decoration: InputDecoration(
            fillColor: Colors.blueAccent,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.black45),
            labelStyle: TextStyle(color: Colors.black45),
            labelText: label,
            //border: OutlineInputBorder(),
            border: InputBorder.none,
            prefixIcon: Icon(
              iconObj,
              color: Colors.black45,
            )),
      ),
    );
  }

  _createButton() {
    return Container(
        //margin: EdgeInsets.only(top: 10),
        child: RaisedButton(
      elevation: 15,
      color: Colors.grey,
      onPressed: () {}, //onPressed of RaisedButton
      child: IconButton(
        icon: Icon(Icons.login),
        color: Colors.black,
        iconSize: 30,
        hoverColor: Colors.yellowAccent,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Music()));
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        //This stack will give a container on top of background Image
        //which will look decent
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              Constants.LOGIN_BG_2,
              fit: BoxFit.cover,
            ),

            /*
            Container(
              color: Colors.white54,
              height: media.height / 2,
              width: media.width / 2,
            )

            Note:: Container will take the whole width and height of the screen
            irrespective of which we have provided
            due to the fact that we usd StackFit.expand

            */

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      height: media.height * 0.50,
                      width: media.width * 0.75,
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _createTextFields(
                              hintText: 'Enter User id',
                              label: 'User id',
                              iconObj: Icons.person,
                              isPwd: false),
                          _createTextFields(
                              hintText: 'Enter Password',
                              label: 'Password',
                              iconObj: Icons.lock,
                              isPwd: true),
                          _createButton()
                        ],
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
