

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

import 'RandomWords.dart';

class SavedWords extends StatelessWidget {

  final Set<WordPair> savedPairs;

  const SavedWords({Key key, this.savedPairs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tiles = this.savedPairs.map((pair) {
      return ListTile(
        title: Text(
          pair.asPascalCase,
          style: biggerFont,
        ),
      );
    });
    final divided = ListTile
      .divideTiles(
        context: context,
        tiles: tiles
      )
      .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('已保存'),
      ),
      body: ListView(children: divided),
    );
  }
}

Widget build(dynamic input) {
  
}