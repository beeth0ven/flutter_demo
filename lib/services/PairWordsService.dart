
import 'package:english_words/english_words.dart';

class PairWordsService {

  Future<List<WordPair>> asyncRandomWords() async {
    final words = generateWordPairs().take(8).toList();
    return Future.delayed(Duration(seconds: 3), () => words);
  }

  Future<List<WordPair>> error() async {
    return Future.delayed(Duration(seconds: 3), () => throw '404 无法获取数据');
  }


}