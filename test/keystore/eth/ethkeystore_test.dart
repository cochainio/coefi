import 'package:test/test.dart';

import 'package:coefi/keystore/eth/ethkeystore.dart';

void main() {
  final testPassword = "password";
  const testPrivHex = "09e910621c2e988e9f7f6ffcd7024f54ec1461fa6e86a4b545e9e1fe21c28868";

  group('ETH Keystore', () {
    test('exception', () {
      expect(() => ETHKeystore.from(testPassword, "09e910621c2e988e9f7f6ffcd7024f54ec1461fa6e86a4b545e9e1fe21c288"), throwsArgumentError);
    });

    test('private key', () {
      var ks = ETHKeystore.from(testPassword, testPrivHex);
      expect(ks.privateKey(testPassword), testPrivHex);
    });

    test('change password', () {
      var ks = ETHKeystore.from(testPassword, testPrivHex);
      expect(ks.privateKey(testPassword), testPrivHex);
      var newPassword = "newpassowrd";
      expect(() => ks.changePassword(newPassword, testPassword), throwsArgumentError);
      ks.changePassword(testPassword, newPassword);
      expect(ks.privateKey(newPassword), testPrivHex);
    });
  });
}
