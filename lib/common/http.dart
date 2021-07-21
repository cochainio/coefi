import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

import '../config/config.dart';

export 'package:dio/dio.dart';
export 'package:dio_http_cache/dio_http_cache.dart' show buildCacheOptions;

const kDioCacheFilename = 'httpcache.db';

/// Build Dio instance based on global config.
/// If you want to utilize cache, you must set [cacheAge] greater than [Duration.zero], or set [forceUseCache] to true.
Dio buildDio({
  // Cache max age
  Duration cacheAge = Duration.zero,
  bool forceUseCache = false,
  String? cacheFilename, // only for testing
  // copyWith options are copied from options.dart in dio package.
  String? method,
  String? baseUrl,
  Map<String, dynamic>? queryParameters,
  String? path,
  int? connectTimeout,
  int? receiveTimeout,
  int? sendTimeout,
  Map<String, dynamic>? extra,
  Map<String, dynamic>? headers,
  ResponseType? responseType,
  String? contentType,
  ValidateStatus? validateStatus,
  bool? receiveDataWhenStatusError,
  bool? followRedirects,
  int? maxRedirects,
  RequestEncoder? requestEncoder,
  ResponseDecoder? responseDecoder,
  ListFormat? listFormat,
  bool? setRequestContentTypeWhenNoPayload,
}) {
  final dio = Dio(Config.dioOptions.copyWith(
    method: method,
    baseUrl: baseUrl,
    queryParameters: queryParameters,
    path: path,
    connectTimeout: connectTimeout,
    receiveTimeout: receiveTimeout,
    sendTimeout: sendTimeout,
    extra: extra,
    headers: headers,
    responseType: responseType,
    contentType: contentType,
    validateStatus: validateStatus,
    receiveDataWhenStatusError: receiveDataWhenStatusError,
    followRedirects: followRedirects,
    maxRedirects: maxRedirects,
    requestEncoder: requestEncoder,
    responseDecoder: responseDecoder,
  ));

  if (cacheAge > Duration.zero || forceUseCache) {
    var databaseName = cacheFilename;
    if (databaseName == null) {
      databaseName = kDioCacheFilename;
    } else if (Config.buildMode == BuildMode.release) {
      // All dio cache should use the same default database
      throw ArgumentError.value(cacheFilename, 'cacheFilename', 'Must be null');
    }
    if (databaseName.endsWith('.db')) {
      databaseName = databaseName.substring(0, databaseName.lastIndexOf('.db'));
    }

    final cfg = Config.dioCacheConfig;
    final cacheConfig = CacheConfig(
      defaultMaxAge: cacheAge > Duration.zero ? cacheAge : Duration.zero,
      defaultMaxStale: cfg.defaultMaxStale,
      defaultRequestMethod: cfg.defaultRequestMethod,
      databasePath: cfg.databasePath,
      databaseName: databaseName,
      baseUrl: cfg.baseUrl,
      skipDiskCache: cfg.skipDiskCache,
      skipMemoryCache: cfg.skipMemoryCache,
      maxMemoryCacheCount: cfg.maxMemoryCacheCount,
      encrypt: cfg.encrypt,
      decrypt: cfg.decrypt,
      diskStore: cfg.diskStore,
    );
    dio.interceptors.add(DioCacheManager(cacheConfig).interceptor);
  }

  return dio;
}
