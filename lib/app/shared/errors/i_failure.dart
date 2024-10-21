abstract class IAppFailure implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const IAppFailure({
    required this.message,
    required this.stackTrace,
  });
}
