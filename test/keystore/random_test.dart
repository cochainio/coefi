import 'package:test/test.dart';

import 'package:coefi/keystore/random.dart';

void main() {
  group('CryptoRandom', () {
    test('random generation uint8', () {
      final r = CryptoRandom();
      final i1 = r.nextUint8();
      final i2 = r.nextUint8();
      final i3 = r.nextUint8();
      expect(i2, isNot(i1));
      expect(i3, isNot(i1));
      expect(i3, isNot(i2));
    });
    test('random generation uint16', () {
      final r = CryptoRandom();
      final i1 = r.nextUint16();
      final i2 = r.nextUint16();
      final i3 = r.nextUint16();
      expect(i2, isNot(i1));
      expect(i3, isNot(i1));
      expect(i3, isNot(i2));
    });
    test('random generation uint32', () {
      final r = CryptoRandom();
      final i1 = r.nextUint32();
      final i2 = r.nextUint32();
      final i3 = r.nextUint32();
      expect(i2, isNot(i1));
      expect(i3, isNot(i1));
      expect(i3, isNot(i2));
    });
    test('random generation BigInt', () {
      final r = CryptoRandom();
      final i1 = r.nextBigInteger(30);
      final i2 = r.nextBigInteger(60);
      final i3 = r.nextBigInteger(120);
      expect(i1.bitLength, lessThanOrEqualTo(30));
      expect(i2.bitLength, lessThanOrEqualTo(60));
      expect(i3.bitLength, lessThanOrEqualTo(120));
      expect(i2, isNot(i1));
      expect(i3, isNot(i1));
      expect(i3, isNot(i2));
    });
    test('generate bytes', () {
      final r = CryptoRandom();
      expect(r.nextBytes(0).length, 0);
      expect(r.nextBytes(32).length, 32);
      expect(r.nextBytes(64).length, 64);
    });
  });
}
