class ApiException implements Exception {
  final String msg;
  final int? statusCode;
  ApiException(this.msg, this.statusCode);

  factory ApiException.badRequest() {
    return ApiException("Bad Request", 400);
  }

  factory ApiException.unauthorized() {
    return ApiException("Unauthorized", 401);
  }

  factory ApiException.forbidden() {
    return ApiException("Forbidden", 403);
  }

  factory ApiException.notFound(String? obj) {
    return ApiException(obj ?? "Not Found", 404);
  }

  factory ApiException.internalServerError() {
    return ApiException("Internal Server Error", 500);
  }
}
