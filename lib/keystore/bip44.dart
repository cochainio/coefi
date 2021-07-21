// https://github.com/bitcoin/bips/blob/master/bip-0044.mediawiki
// https://github.com/satoshilabs/slips/blob/master/slip-0044.md
// https://github.com/bitcoin/bips/blob/master/bip-0049.mediawiki
class BIP44 {
  // ignore: constant_identifier_names
  static const String BTCMainnet = "m/44'/0'/0'";
  // ignore: constant_identifier_names
  static const String BTCTestnet = "m/44'/1'/0'";
  // ignore: constant_identifier_names
  static const String BTCSegWitMainnet = "m/49'/0'/0'";
  // ignore: constant_identifier_names
  static const String BTCSegWitTestnet = "m/49'/1'/0'";
  // ignore: constant_identifier_names
  static const String ETH = "m/44'/60'/0'/0/0";
  // ignore: constant_identifier_names
  static const String EOSOwner = "m/44'/194'/0'/0/0";
  // ignore: constant_identifier_names
  static const String EOSActive = "m/44'/194'/0'/0/1";
  // ignore: constant_identifier_names
  static const String ATOM = "m/44'/118'/0'/0/0";

  static String btcHDPath(bool isMainnet, bool isSegWit) {
    if (isMainnet) {
      return isSegWit ? BTCSegWitMainnet : BTCMainnet;
    } else {
      return isSegWit ? BTCSegWitTestnet : BTCTestnet;
    }
  }
}
