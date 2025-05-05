class LocalException implements Exception {
  final String message;

  LocalException(this.message);

  @override
  String toString() => 'LocalException: $message';
}
