import 'package:test/test.dart';

import 'package:coefi/keystore/bip44.dart';

void main() {
  group('BTC HD path', () {
    test('BTC HD path seg mainnet', () {
      var path = BIP44.btcHDPath(true, true);
      expect(path, equals(BIP44.BTCSegWitMainnet));
    });

    test('BTC HD path mainnet', () {
      var path = BIP44.btcHDPath(true, false);
      expect(path, equals(BIP44.BTCMainnet));
    });

    test('BTC HD path seg testnet', () {
      var path = BIP44.btcHDPath(false, true);
      expect(path, equals(BIP44.BTCSegWitTestnet));
    });

    test('BTC HD path testnet', () {
      var path = BIP44.btcHDPath(false, false);
      expect(path, equals(BIP44.BTCTestnet));
    });
  });
}
