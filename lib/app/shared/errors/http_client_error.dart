import 'package:minicore_arch_example/app/shared/errors/i_failure.dart';

class HttpClientError extends IAppFailure {
  final dynamic data;

  const HttpClientError({
    required this.data,
    required super.message,
    required super.stackTrace,
  });
}
