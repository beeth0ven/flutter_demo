

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/pages/SavedWords.dart';

class RandomWords extends StatefulWidget {

  @override
  createState() => _RandomWordState();
}

final TextStyle biggerFont = const TextStyle(fontSize: 18);

class _RandomWordState extends State<RandomWords> {

  // state
  final List<WordPair> _suggestions = [];
  final Set<WordPair> _saved = Set<WordPair>();

  // event

  void _onMenuTapped() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SavedWords(savedPairs: _saved)
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('你好'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _onMenuTapped),
        ],
      ),
      body: Center(
        child: _buildSuggestions(),
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemBuilder: (BuildContext _context, int i) {
        if (i.isOdd) return Divider();

        final int index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        final pair = _suggestions[index];

        return _buildRow(pair);
      }
    );
  }

  Widget _buildRow(WordPair pair) {
    final bool isSaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: biggerFont,
      ),
      trailing: Icon(
        isSaved ? Icons.favorite : Icons.favorite_border,
        color: isSaved ? Colors.red : null,
      ),
      onTap: () => _onPairTap(pair, isSaved),
    );
  }

  void _onPairTap(WordPair pair, bool isSaved) {
    setState(() {
      if (isSaved) {
        _saved.remove(pair);
      } else {
        _saved.add(pair);
      }
    });
  }
}