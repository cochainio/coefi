import 'package:dio/dio.dart' as dio;
import 'package:dio_http_cache/dio_http_cache.dart' as dio;

import 'env.dart';
import 'chain.dart';

export 'env.dart' show BuildMode;
export 'chain.dart';

/// Application level static configuration for customizing app.
// ignore: avoid_classes_with_only_static_members
class Config {
  static const appName = 'CoeFi';

  static final dioOptions = dio.BaseOptions(
    connectTimeout: 5000,
    receiveTimeout: 3000,
    sendTimeout: 3000,
  );

  static final dioCacheConfig = dio.CacheConfig(
    // How long to allow to use expired cache when network failure
    defaultMaxStale: const Duration(days: 7),
    maxMemoryCacheCount: 1000,
  );

  static const grpcTimeout = Duration(seconds: 5);

  static final BuildMode buildMode = getBuildMode();

  static final Map<ChainCoin, Chain> chains = chainsConfig;
}

final Map<ChainCoin, Chain> chainsConfig = {
  ChainCoin.BTC: Chain(
    coin: ChainCoin.BTC,
    type: ChainType.BTC,
    name: 'Bitcoin',
    icon: 'assets/images/coins/btc.png',
    nodeURL: '',
  ),
  ChainCoin.ETH: Chain(
    coin: ChainCoin.ETH,
    type: ChainType.ETH,
    chainID: '1',
    name: 'Ethereum',
    icon: 'assets/images/coins/eth.png',
    nodeURL: 'https://mainnet.infura.io/v3/25a0b20101c14e74a133f1fd51e3beae',
  ),
  ChainCoin.EOS: Chain(
    coin: ChainCoin.EOS,
    type: ChainType.EOS,
    chainID: 'aca376f206b8fc25a6ed44dbdc66547c36c6c33e3a119ffbeaef943642f0e906',
    name: 'EOS',
    icon: 'assets/images/coins/eos.png',
    nodeURL: 'https://api.main.alohaeos.com',
    vendorURL: 'https://www.api.bloks.io',
  ),
  ChainCoin.FIL: Chain(
    coin: ChainCoin.FIL,
    type: ChainType.FILECOIN,
    name: 'Filecoin',
    icon: 'assets/images/coins/fil.png',
    nodeURL:
        'https://1vcIIxZbXKA1axbK8ygFC3vTdRU:d3f77bb36ccdb228d6047c174b3dc4a6@filecoin.infura.io',
  ),
  ChainCoin.ATOM: Chain(
    coin: ChainCoin.ATOM,
    type: ChainType.COSMOS,
    chainID: 'cosmoshub-2',
    name: 'COSMOS',
    icon: 'assets/images/coins/cosmos.png',
    nodeURL: 'https://stargate.cosmos.network',
  ),
  ChainCoin.SOL: Chain(
    coin: ChainCoin.SOL,
    type: ChainType.SOLANA,
    name: 'Solana',
    icon: 'assets/images/coins/solana.svg',
    nodeURL: 'https://api.mainnet-beta.solana.com',
  ),
};
