import 'package:calc/screens/calc3.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: SafeArea(child: Calc3()),
    ),
  );
}
