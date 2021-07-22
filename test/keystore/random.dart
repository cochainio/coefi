import 'package:test/test.dart';

import 'package:coefi/keystore/random.dart';

void main() {
  group('CryptoRandom', () {
    test('random generation', () {
      final r = CryptoRandom();
      final i1 = r.nextUint8();
      final i2 = r.nextUint8();
      final i3 = r.nextUint8();
      expect(i2, isNot(i1));
      expect(i3, isNot(i1));
      expect(i3, isNot(i2));
    });
    test('generate bytes', () {
      final r = CryptoRandom();
      expect(r.nextBytes(64).length, 64);
    });
  });
}
