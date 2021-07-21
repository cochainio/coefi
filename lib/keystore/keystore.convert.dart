import 'dart:convert';

import 'package:moor/moor.dart';

import './btc/btckeystore.dart';
import './eth/ethkeystore.dart';
import './keystore.dart';

class KeystoreConverter extends TypeConverter<Keystore, String> {
  const KeystoreConverter();

  @override
  Keystore? mapToDart(String? fromDb) {
    if (fromDb == null) {
      return null;
    }
    return Keystore.fromJson(json.decode(fromDb));
  }

  @override
  String? mapToSql(Keystore? value) {
    if (value == null) {
      return null;
    }
    return json.encode(value.toJson());
  }
}

class MnemonicKeystoreConverter extends TypeConverter<MnemonicKeystore, String> {
  const MnemonicKeystoreConverter();

  @override
  MnemonicKeystore? mapToDart(String? fromDb) {
    if (fromDb == null) {
      return null;
    }
    return MnemonicKeystore.fromJson(json.decode(fromDb));
  }

  @override
  String? mapToSql(MnemonicKeystore? value) {
    if (value == null) {
      return null;
    }
    return json.encode(value.toJson());
  }
}

Keystore keystoreFromJson(KeystoreType keystoreType, Map<String, dynamic> json) {
  switch (keystoreType) {
    case KeystoreType.BTC:
      return BTCKeystore.fromJson(json);
    case KeystoreType.BTCMnemonic:
      return BTCMnemonicKeystore.fromJson(json);
    case KeystoreType.ETH:
      return ETHKeystore.fromJson(json);
    case KeystoreType.ETHMnemonic:
      return ETHMnemonicKeystore.fromJson(json);
  }
  // ignore: dead_code
  throw ArgumentError(); // never happen
}
