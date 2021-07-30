import 'package:test/test.dart';

import 'package:coefi/keystore/key.dart';
import 'package:bitcoin_flutter/bitcoin_flutter.dart' show bitcoin, testnet;

void main() {
  const testPubHex = "024c502fe78727b0f2c06da402d42f75c34596e66ea3b2f808c02cbf5d5ca1e43a";
  const testPrivHex = "09e910621c2e988e9f7f6ffcd7024f54ec1461fa6e86a4b545e9e1fe21c28868";

  group('Key', () {
    test('PublicKey match PrivateKey', () {
      var pubKey = PublicKey.fromHex(testPubHex);
      var privKey = PrivateKey.fromHex(testPrivHex);
      expect(pubKey.toHex(), testPubHex);
      expect(privKey.publicKey().toHex(), testPubHex);
      expect(privKey.toHex(), testPrivHex);
    });
  });
}
