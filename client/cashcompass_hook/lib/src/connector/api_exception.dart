class ApiException implements Exception {
  final String msg;
  final int? statusCode;
  final String? body;
  ApiException(this.msg, this.statusCode, {this.body});

  factory ApiException.badRequest(String body) {
    return ApiException("Bad Request", 400, body: body);
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

  @override
  String toString() {
    // TODO: implement toString
    return "$statusCode: $msg ${body ?? ""}";
  }
}
