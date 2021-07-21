import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Chain {
  final ChainCoin coin; // chain native coin name (usually uniquely identify a specific chain), e.g., ETH, ETC
  final ChainType type; // chain underlying type, e.g., ETH
  final String? chainID; // chain id
  final bool isTestNet;
  final String name; // full name, e.g., 'Ethereum', 'Ethereum Classic'
  final dynamic icon;
  final dynamic
      iconPlaceholder; // icon placeholder for smart contract tokens of which the original icon cannot be found; it could be the faded version of `icon`
  final String? nodeURL; // public api url of specific chain node, e.g., https://mainnet.infura.io
  final String? vendorURL; // public api url provided by specific vendor
  final Map<String, dynamic>? extra;

  Chain({
    required this.coin,
    required this.type,
    this.chainID,
    this.isTestNet = false,
    required this.name,
    required String icon,
    String? iconPlaceholder, // should not be specified if smart contract token is not supported
    this.nodeURL,
    this.vendorURL,
    this.extra,
  })  : icon = _buildIcon(icon),
        iconPlaceholder = _buildIcon(iconPlaceholder);
}

dynamic _buildIcon(String? icon) {
  if (icon == null) {
    return null;
  }
  if (icon.endsWith('.svg')) {
    return SvgPicture.asset(icon);
  } else {
    return AssetImage(icon);
  }
}

@immutable
class ChainType {
  // ignore: constant_identifier_names
  static const ChainType BTC = ChainType._('BTC');

  // ignore: constant_identifier_names
  static const ChainType ETH = ChainType._('ETH');

  // ignore: constant_identifier_names
  static const ChainType EOS = ChainType._('EOS');

  // ignore: constant_identifier_names
  static const ChainType TRX = ChainType._('TRX');

  // ignore: constant_identifier_names
  static const ChainType FILECOIN = ChainType._('FILECOIN');

  // ignore: constant_identifier_names
  static const ChainType COSMOS = ChainType._('COSMOS');

  // ignore: constant_identifier_names
  static const ChainType SOLANA = ChainType._('SOLANA');

  final String name;

  const ChainType._(this.name);

  @override
  bool operator ==(other) {
    return other is ChainType && name == other.name;
  }

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() => name;
}

@immutable
class ChainCoin {
  // ignore: constant_identifier_names
  static const BTC = ChainCoin._('BTC');

  // ignore: constant_identifier_names
  static const BCH = ChainCoin._('BCH');

  // ignore: constant_identifier_names
  static const BSV = ChainCoin._('BSV');

  // ignore: constant_identifier_names
  static const ETH = ChainCoin._('ETH');

  // ignore: constant_identifier_names
  static const ETC = ChainCoin._('ETC');

  // ignore: constant_identifier_names
  static const EOS = ChainCoin._('EOS');

  // ignore: constant_identifier_names
  static const TRX = ChainCoin._('TRX');

  // ignore: constant_identifier_names
  static const FIL = ChainCoin._('FIL'); // Filecoin
  // ignore: constant_identifier_names
  static const ATOM = ChainCoin._('ATOM'); // Cosmos
  // ignore: constant_identifier_names
  static const SOL = ChainCoin._('SOL'); // Solana

  final String name;

  const ChainCoin._(this.name);

  @override
  bool operator ==(other) {
    return other is ChainCoin && name == other.name;
  }

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() => name;
}
