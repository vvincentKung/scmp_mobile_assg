class ErrorResponse {
  final String error;

  ErrorResponse({
    required this.error,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      error: json['error'] != null ? json['error'] as String : 'Invalid response',
    );
  }
}