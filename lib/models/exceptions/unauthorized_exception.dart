class UnauthorizedException implements Exception {
  final int code;
  final String message;
  final String? url;

  UnauthorizedException({
    this.code = 401,
    this.message = "Unauthorized Access",
    this.url,
  });

  @override
  String toString() {
    return 'Unauthorized: $message';
  }
}