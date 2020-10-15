import 'package:flutter/material.dart';

class TextFieldDemo extends StatefulWidget {
  @override
  _TextFieldDemoState createState() => _TextFieldDemoState();
}

class _TextFieldDemoState extends State<TextFieldDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.teal,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black45,

                    //decorationColor: Colors.white
                    //this will give a line below the entered text
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person_add,
                      color: Colors.purpleAccent,
                      size: 50,
                    ),
                    //prefixStyle: TextStyle(color: Colors.purpleAccent),
                    labelStyle: TextStyle(color: Colors.yellowAccent),
                    hintStyle: TextStyle(color: Colors.orangeAccent),
                    labelText: 'Enter your name',
                    hintText: 'Type your name',
                    //fillColor: Colors.red,
                    focusColor: Colors.blueAccent,
                    hoverColor: Colors.yellowAccent,
                    border: OutlineInputBorder(
                      //color of border is not working unless i specify focused border
                      borderSide:
                          BorderSide(color: Colors.redAccent, width: 5.0),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.yellowAccent, width: 3.0),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
