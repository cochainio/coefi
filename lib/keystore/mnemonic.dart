/// https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki

import 'dart:typed_data';
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:bip39/bip39.dart' as bip39;
import 'package:bip39/src/wordlists/english.dart' as eng; // ignore: implementation_imports

class Mnemonic {
  // ignore: constant_identifier_names
  static const ChineseSimplified = '中文简体';

  // ignore: constant_identifier_names
  static const ChineseTraditional = '中文繁体';

  // ignore: constant_identifier_names
  static const English = 'English';

  // ignore: constant_identifier_names
  static const French = 'Français';

  // ignore: constant_identifier_names
  static const Italian = 'Italiano';

  // ignore: constant_identifier_names
  static const Japanese = '日本語';

  // ignore: constant_identifier_names
  static const Korean = '한국어';

  // ignore: constant_identifier_names
  static const Spanish = 'Español';

  static const List<String> languages = [
    ChineseSimplified,
    ChineseTraditional,
    English,
    French,
    Italian,
    Japanese,
    Korean,
    Spanish,
  ];
  static final Map<String, List<String>> wordLists = {
    ChineseSimplified: ['chinese_simplified.json'],
    ChineseTraditional: ['chinese_traditional.json'],
    English: eng.WORDLIST,
    French: ['french.json'],
    Italian: ['italian.json'],
    Japanese: ['japanese.json'],
    Korean: ['korean.json'],
    Spanish: ['spanish.json'],
  };

  static Future<List<String>> loadWordList(String language) async {
    var wordList = wordLists[language];
    if (wordList == null) throw ArgumentError('no word list for $language');
    if (wordList.length == 1) {
      var wordListStr = await rootBundle.loadString('packages/bip39/src/wordlists/${wordList[0]}');
      wordList = (jsonDecode(wordListStr) as List<dynamic>).cast<String>();
      wordLists[language] = wordList;
    }
    return wordList;
  }

  static const Map<int, int> strengthToLength = {
    128: 12,
    160: 15,
    192: 18,
    224: 21,
    256: 24,
  };

  static String generateMnemonic([String? language, int strength = 128]) {
    language ??= English;
    if (!strengthToLength.containsKey(strength)) throw ArgumentError.value(strength, 'strength');
    var wordList = wordLists[language];
    if (wordList == null || wordList.length == 1) {
      throw ArgumentError('word list for language `$language` is not loaded');
    }
    return bip39.generateMnemonic(wordList: wordList, strength: strength);
  }

  static Uint8List mnemonicToSeed(String mnemonic) {
    return bip39.mnemonicToSeed(mnemonic);
  }
}
