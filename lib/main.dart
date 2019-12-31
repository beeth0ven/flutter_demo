import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/pages/RandomWords.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: RandomWords()
    );
  }
}
