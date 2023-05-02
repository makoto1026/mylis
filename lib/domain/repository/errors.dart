class ApiError implements Exception {
  ApiError({
    this.message,
    required this.code,
  });
  String? message;
  String code;
}
