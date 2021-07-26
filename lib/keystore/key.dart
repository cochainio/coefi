import 'dart:typed_data';

// ignore: import_of_legacy_library_into_null_safe
import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:web3dart/crypto.dart';
import 'package:bip32/src/utils/ecurve.dart'
    as ecc; // ignore: implementation_imports

abstract class Key {}

class PublicKey implements Key {
  final ECPair ecPair;

  PublicKey() : ecPair = ECPair.makeRandom();

  PublicKey.fromBytes(Uint8List publicKey)
      : ecPair = ECPair.fromPublicKey(publicKey);

  PublicKey.fromHex(String publicKey) : this.fromBytes(hexToBytes(publicKey));

  Uint8List toBytes() => ecPair.publicKey!;

  String toHex() => bytesToHex(ecPair.publicKey!);

  bool get compressed => ecPair.publicKey![0] != 0x04;

  bool verify(Uint8List hash, Uint8List signature, {bool? compressed}) {
    return ecc.verify(
        hash, _ecPair(ecPair, compressed: compressed).publicKey!, signature);
  }
}

class PrivateKey implements Key {
  final ECPair ecPair;

  PrivateKey() : ecPair = ECPair.makeRandom();

  PrivateKey.fromBytes(Uint8List privateKey)
      : ecPair = ECPair.fromPrivateKey(privateKey);

  PrivateKey.fromHex(String privateKey)
      : this.fromBytes(hexToBytes(privateKey));

  PrivateKey.fromWIF(String wif)
      : ecPair = ECPair.fromWIF(
            wif); // here `network.wif` and `compressed` may matter

  Uint8List toBytes() => ecPair.privateKey!;

  String toHex() => bytesToHex(ecPair.privateKey!);

  String toWIF({NetworkType? network, int? wif, bool? compressed}) {
    return _ecPair(ecPair, network: network, wif: wif, compressed: compressed)
        .toWIF();
  }

  PublicKey publicKey({bool? compressed}) {
    return PublicKey.fromBytes(
        _ecPair(ecPair, compressed: compressed).publicKey!);
  }

  Uint8List sign(Uint8List hash) {
    return ecPair.sign(hash);
  }

  bool verify(Uint8List hash, Uint8List signature, {bool? compressed}) {
    return ecc.verify(
        hash, publicKey(compressed: compressed).ecPair.publicKey!, signature);
  }
}

ECPair _ecPair(ECPair ecPair,
    {NetworkType? network, int? wif, bool? compressed}) {
  var ecp = ecPair;
  if ((network != null && network.wif != ecp.network.wif) ||
      (wif != null && wif != ecp.network.wif) ||
      (compressed != null && compressed != ecp.compressed)) {
    if (network == null && wif != null) {
      // prefer `network` than `wif`
      network = _networkForWIF(wif);
    }
    ecp = ECPair.fromPrivateKey(ecp.privateKey!,
        network: network, compressed: compressed);
  }
  return ecp;
}

NetworkType _networkForWIF(int wif) {
  // only `wif` matters
  return NetworkType(
      messagePrefix: '',
      bech32: '',
      bip32: Bip32Type(public: 0, private: 0),
      pubKeyHash: 0,
      scriptHash: 0,
      wif: wif);
}
