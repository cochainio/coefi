import 'package:grpc/grpc.dart';

ClientChannel buildGrpcChannel(String endpoint) {
  const defOpts = ChannelOptions();

  final uri = Uri.parse(endpoint);

  var isSecure = false;
  if (uri.scheme == 'https') {
    isSecure = true;
  } else if (uri.scheme == 'http') {
  } else {
    throw ArgumentError.value(uri.scheme, 'scheme', 'Must be http or https');
  }

  final options = ChannelOptions(
    credentials: isSecure
        ? const ChannelCredentials.secure()
        : const ChannelCredentials.insecure(),
    idleTimeout: defOpts.idleTimeout,
    userAgent: defOpts.userAgent,
    backoffStrategy: defOpts.backoffStrategy,
    connectionTimeout: defOpts.connectionTimeout,
  );

  return ClientChannel(uri.host, port: uri.port, options: options);
}
