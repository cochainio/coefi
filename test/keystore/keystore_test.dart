import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';

import 'package:coefi/keystore/keystore.dart';

void main() {
  final file = File('test/keystore/keystore_fixture.json');
  final Map keystores = jsonDecode(file.readAsStringSync());

  group('Keystore', () {
    keystores.forEach((testName, content) {
      test('JSON encoding and decoding for $testName', () {
        final password = content['password'] as String;
        final privateKey = content['priv'] as String;
        final keystoreJson = content['json'] as Map<String, dynamic>;

        final keystore = Keystore.fromJson(keystoreJson);
        keystore.validate(password, willThrow: true, cacheDerivedKey: true);

        expect(bytesToHex(keystore.secret(password)), privateKey);

        final encoded = keystore.toJson();

        expect(encoded['crypto']['ciphertext'],
            keystoreJson['crypto']['ciphertext']);
      });
    });
  });
}
