

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/pages/SavedWords.dart';

class RandomWords extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _RandomWordsState();
  }
}

class _RandomWordsState extends State<RandomWords> {

  // state
  final List<WordPair> _suggestion = [];
  final Set<WordPair> _saved = Set<WordPair>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);

  // event
  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return SavedWords(savedWords: _saved);
        }
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: Center(
        child: _buildSuggestions(),
      ),
    );
  }
  
  Widget _buildSuggestions() {

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (BuildContext _context, int i) {
        if (i.isOdd) {
          return Divider();
        }

        final int index = i ~/ 2;
        
        if (index >= _suggestion.length) {
          final words = generateWordPairs().take(10).toList();
          _suggestion.addAll(words);
        }

        final word = _suggestion[index];

        return _buildRow(word);
      }
    );
  }

  Widget _buildRow(WordPair word) {
    final isSaved = _saved.contains(word);
    return ListTile(
      title: Text(
        word.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        isSaved ? Icons.favorite : Icons.favorite_border,
        color: isSaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (isSaved) {
            _saved.remove(word);
          } else {
            _saved.add(word);
          }
        });
      },
    );
  }

}