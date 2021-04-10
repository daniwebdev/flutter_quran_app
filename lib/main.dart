import 'package:flutter/material.dart';
import 'package:flutter_quran_app/screens/intro/intro_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      fontFamily: 'QuickSand',
        primarySwatch: Colors.blue,
      ),
      home: IntroScreen(),
    );
  }
}
