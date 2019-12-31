

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class SavedWords extends StatelessWidget {

  final Set<WordPair> savedWords;

  const SavedWords({Key key, this.savedWords}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tiles = savedWords.map((WordPair word) {
      return ListTile(
        title: Text(
          word.asPascalCase,
          // style: _biggerFont,
        ),
      );
    });

    final List<Widget> divided = ListTile
      .divideTiles(
        context: context,
        tiles: tiles
      ).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Saved'),
      ),
      body: ListView(children: divided),
    );
  }
}