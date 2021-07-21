import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/api.dart';
import 'package:web3dart/crypto.dart';

/// An implementation of pointycastle's [SecureRandom] with dart:math's [Random].
class CryptoRandom implements SecureRandom {
  static final CryptoRandom global = CryptoRandom();

  final Random _random;

  CryptoRandom() : _random = Random.secure();

  @override
  String get algorithmName => 'CryptoRandom';

  @override
  BigInt nextBigInteger(int bitLength) {
    final fullBytes = bitLength ~/ 8;
    final remainingBits = bitLength % 8;

    // Generate a number from the full bytes. Then, prepend a smaller number
    // covering the remaining bits.
    final main = bytesToInt(nextBytes(fullBytes));
    final additional = _random.nextInt(1 << remainingBits);
    return main + (BigInt.from(additional) << (fullBytes * 8));
  }

  @override
  Uint8List nextBytes(int count) {
    final list = Uint8List(count);

    for (var i = 0; i < list.length; i++) {
      list[i] = nextUint8();
    }

    return list;
  }

  @override
  int nextUint16() => _random.nextInt(1 << 16);

  @override
  int nextUint32() => _random.nextInt(1 << 32);

  @override
  int nextUint8() => _random.nextInt(1 << 8);

  @override
  void seed(CipherParameters params) {
    // ignore, already seeded
  }
}
