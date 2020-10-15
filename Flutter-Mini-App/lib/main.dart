import 'package:flutter/material.dart';
import 'package:music_app/screens/login.dart';
import 'package:music_app/screens/music.dart';
import './screens/splashscreen.dart';
import 'package:music_app/main.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData.dark(),
    title: 'Music App 2020',
    home: SplashScreen(),
  ));
}
