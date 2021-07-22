import 'dart:convert';

import 'package:moor/moor.dart';
import 'package:test/test.dart';

import 'package:coefi/keystore/crypto.dart';

import '../print.dart';

void main() {
  const password = 'testpassword';
  final secret = hexToBytes('7a28b5ba57c53603b0b07b56bba752f7784bf506fa95edc395f5cf6c7514fe9d');

  group('Crypto', () {
    test('random generation timer', () {
      final sw = Stopwatch();
      sw.start();
      final c1 = Crypto.from(password, secret, cacheDerivedKey: true);
      c1.validate(password, willThrow: true);
      printWrapped('Scrypt elapsed ${sw.elapsed}');

      sw.reset();
      final c2 = Crypto.from(password, secret, kdfParams: PBKDF2KdfDerivator(c: 65536), cacheDerivedKey: true);
      c2.validate(password, willThrow: true);
      printWrapped('PBKDF2 elapsed ${sw.elapsed}');

      sw.stop();
    });
    test('JSON encoding and decoding', () {
      final c1 = Crypto.from(password, secret);
      final str = jsonEncode(c1);
      final c2 = Crypto.fromJson(jsonDecode(str));
      expect(jsonEncode(c2), str);
    });
    test('encrypt and decrypt message', () {
      const msg = 'message';
      final msgBytes = utf8.encode(msg) as Uint8List;
      final c = Crypto.from(password, secret, cacheDerivedKey: true);

      final s1 = c.encryptMessage(password, msgBytes);
      final s2 = c.encryptMessage(password, msgBytes);
      expect(bytesToHex(s1.cipherText), isNot(bytesToHex(s2.cipherText)));
      expect(bytesToHex(s1.nonce), isNot(bytesToHex(s2.nonce)));

      final d1 = c.decryptMessage(password, s1);
      final d2 = c.decryptMessage(password, s2);
      expect(utf8.decode(d1), msg);
      expect(utf8.decode(d2), msg);
    });
  });
}
