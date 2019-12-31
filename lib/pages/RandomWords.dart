

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/pages/SavedWords.dart';
import 'package:hello_world/services/PairWordsService.dart';

class RandomWords extends StatefulWidget {

  @override
  createState() => _RandomWordState();
}

final TextStyle biggerFont = const TextStyle(fontSize: 18);

class _RandomWordState extends State<RandomWords> {

  // state
  bool _loading = false;
  dynamic _error;
  final List<WordPair> _suggestions = [];
  final Set<WordPair> _saved = Set<WordPair>();

  // event

  @override
  void initState() {
    super.initState();
    _setup();
  }

  void _setup() async {
    final PairWordsService pairWordsService = PairWordsService();

    try {
      setState(() {
        _loading = true;
        _error = null;
      });
      final words = await pairWordsService.asyncRandomWords();
      setState(() {
        _loading = false;
        _suggestions.addAll(words);
      });
    } catch (error) {
      print('error: $error');
      setState(() {
        _loading = false;
        _error = error;
      });
    }
  }

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
    if (_loading) return Text('加载中...');
    if (_error != null) return Text(_error);

    final tiles = _suggestions.map(_buildRow);
    final divided = ListTile
      .divideTiles(
        context: context,
        tiles: tiles
      )
      .toList();
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: divided,
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