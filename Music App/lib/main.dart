import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:music_app/screens/login.dart';
import 'package:music_app/screens/music.dart';
import './screens/splashscreen.dart';
import 'package:music_app/main.dart';

void main() {
  //just wait to initialize the firebase then run app would execute
  WidgetsFlutterBinding.ensureInitialized();

  Firebase.initializeApp();//this is coming from Aug 2020
  runApp(MaterialApp(
    theme: ThemeData.dark(),
    title: 'Music App 2020',
    home: SplashScreen(),
  ));
}
