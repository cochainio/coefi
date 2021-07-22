import 'package:flutter_test/flutter_test.dart';

import 'package:coefi/keystore/mnemonic.dart';

import '../print.dart';

void main() {
  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('Mnemonic', () {
    test('load word lists', () async {
      for (var language in Mnemonic.languages) {
        await Mnemonic.loadWordList(language);
        final mnemonic = Mnemonic.generateMnemonic(language);
        printWrapped('Generate mnemonic of language $language: $mnemonic');
      }
    });
    test('random generation', () {
      final m1 = Mnemonic.generateMnemonic('English');
      final m2 = Mnemonic.generateMnemonic('English');
      expect(m1, isNot(m2));
    });
    test('words count', () {
      Mnemonic.strengthToLength.forEach((strength, length) {
        final mnemonic = Mnemonic.generateMnemonic('English', strength);
        printWrapped('Generate mnemonic of $length words: $mnemonic');
        expect(mnemonic.split(' ').length, length);
      });
    });
  });
}
