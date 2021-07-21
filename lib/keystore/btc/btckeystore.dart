import 'dart:typed_data';
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:bitcoin_flutter/bitcoin_flutter.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:bitcoin_flutter/bitcoin_flutter.dart' show bitcoin, testnet;

import '../keystore.dart';

part 'btckeystore.g.dart';

@JsonSerializable()
class BTCKeystore extends Keystore {
  BTCKeystore();

  BTCKeystore.from(String password,
      {String? wif, Uint8List? privateKey, required bool isMainnet, bool? compressed, String? id, KeystoreMeta? meta})
      : super(id: id, meta: meta) {
    final network = isMainnet ? bitcoin : testnet;

    ECPair ecPair;
    if (wif != null) {
      ecPair = ECPair.fromWIF(wif, network: network);
      if (compressed != null && compressed != ecPair.compressed) throw ArgumentError('Inconsistent `compressed`');
    } else if (privateKey != null) {
      ecPair = ECPair.fromPrivateKey(privateKey, network: network, compressed: compressed);
    } else {
      throw ArgumentError('Only one of `wif` and `privateKey` should be specified');
    }

    crypto = Crypto.from(password, utf8.encode(ecPair.toWIF()) as Uint8List);
  }

  String wif(String password) {
    return utf8.decode(crypto.secret(password));
  }

  String privateKey(String password) {
    return bytesToHex(ECPair.fromWIF(wif(password)).privateKey);
  }

  String publicKey(String password) {
    return bytesToHex(ECPair.fromWIF(wif(password)).publicKey);
  }

  factory BTCKeystore.fromJson(Map<String, dynamic> json) {
    final k = _$BTCKeystoreFromJson(json);
    k.preValidate();
    return k;
  }

  @override
  Map<String, dynamic> toJson() => _$BTCKeystoreToJson(this);
}

@JsonSerializable()
class BTCMnemonicKeystore extends MnemonicKeystore {
  BTCMnemonicKeystore();

  BTCMnemonicKeystore.from(String password,
      {String? mnemonic,
      String? language,
      String? hdPath,
      required bool isMainnet,
      required bool isSegWit,
      String? id,
      KeystoreMeta? meta})
      : super.from(password,
            mnemonic: mnemonic,
            language: language,
            hdPath: hdPath ?? BIP44.btcHDPath(isMainnet, isSegWit),
            isMainnet: isMainnet,
            id: id,
            meta: meta) {
    final regex = RegExp(r"^m(\/\d+'){3}$");
    if (!regex.hasMatch(this.hdPath!)) throw ArgumentError('Invalid HD path');
  }

  String privateKey(String password) {
    return bytesToHex(extendedPrivateKey(password).privateKey!);
  }

  String publicKey(String password) {
    return bytesToHex(extendedPrivateKey(password).publicKey);
  }

  Uint8List derivePrivateKey(String password, {required bool isChange, required int index}) {
    final extendedPrivateKey = this.extendedPrivateKey(password);
    return extendedPrivateKey.derive(isChange ? 1 : 0).derive(index).privateKey!;
  }

  factory BTCMnemonicKeystore.fromJson(Map<String, dynamic> json) {
    final k = _$BTCMnemonicKeystoreFromJson(json);
    k.preValidate();
    return k;
  }

  @override
  Map<String, dynamic> toJson() => _$BTCMnemonicKeystoreToJson(this);
}
