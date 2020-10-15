import 'package:flutter/material.dart';
import 'package:myvsflutterapp/welcome.dart';

import './one.dart';
import './two.dart';
import './second.dart';
import './expanddemo.dart';
import 'welcomeScreen.dart';
import './stackdemo.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData.dark(), //for dark theme
    // theme: ThemeData.light()
    //custom one
    // theme: ThemeData(
    //     fontFamily: 'Roboto',
    //     brightness: Brightness.light,
    //     //primaryColor: Colors.blueAccent
    //     //textTheme: TextTheme()
    //     ),
    title: 'First App',
    debugShowCheckedModeBanner: false,
    home: StackDemo(),
  ));
}
/*
If divided into widgets then hot reload is possible because only that widget is refreshed that have made changes
But in main.dart we have to hot restart it
 */
