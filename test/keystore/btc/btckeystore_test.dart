import 'package:coefi/keystore/crypto.dart';
import 'package:moor/moor.dart';
import 'package:test/test.dart';

import 'package:coefi/keystore/btc/btckeystore.dart';

void main() {
  final testPassword = "password";
  final testPublicKey = "024c502fe78727b0f2c06da402d42f75c34596e66ea3b2f808c02cbf5d5ca1e43a";
  final testPrivateKey = Uint8List.fromList([9, 233, 16, 98, 28, 46, 152, 142, 159, 127, 111, 252, 215, 2, 79, 84, 236, 20, 97, 250, 110, 134, 164, 181, 69, 233, 225, 254, 33, 194, 136, 104]);
  final testWif = "KwYyXZ1vyNEF1czwk2K7uFYnq4XjMPifwBghnFYgZBSYybW3vU9D";

  group('BTC Keystore', () {
    test('exception', () {
      expect(() => BTCKeystore.from(testPassword, isMainnet: true), throwsArgumentError);
      expect(() => BTCKeystore.from(testPassword, isMainnet: false), throwsArgumentError);
    });

    test('btckeystore from privateKey', () {
      var ks = BTCKeystore.from(testPassword, isMainnet: true, privateKey: testPrivateKey);
      expect(ks.privateKey(testPassword), bytesToHex(testPrivateKey));
      expect(() => ks.privateKey("error"), throwsFormatException);
      expect(ks.wif(testPassword), testWif);
      expect(() => ks.wif("error"), throwsFormatException);
      expect(ks.publicKey(testPassword), equals(testPublicKey));
      expect(() => ks.publicKey("error"), throwsFormatException);
    });

    test('btckeystore from wif', () {
      var ks = BTCKeystore.from(testPassword, isMainnet: true, wif: testWif);
      expect(ks.wif(testPassword), testWif);
      expect(() => ks.wif("error"), throwsFormatException);
      expect(ks.privateKey(testPassword), bytesToHex(testPrivateKey));
      expect(() => ks.privateKey("error"), throwsFormatException);
      expect(ks.publicKey(testPassword), equals(testPublicKey));
      expect(() => ks.publicKey("error"), throwsFormatException);
    });

    test('btckeystore change password', () {
      var ks = BTCKeystore.from(testPassword, isMainnet: true, wif: testWif);
      expect(ks.wif(testPassword), testWif);
      var newPassword = "newpassowrd";
      expect(() => ks.changePassword(newPassword, testPassword), throwsArgumentError);
      ks.changePassword(testPassword, newPassword);
      expect(ks.wif(newPassword), testWif);
      expect(() => ks.wif(testPassword), throwsFormatException);
    });
  });
}
