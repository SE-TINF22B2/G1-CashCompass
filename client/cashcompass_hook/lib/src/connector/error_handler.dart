import 'package:cashcompass_hook/src/connector/api_exception.dart';
import 'package:http/http.dart';

/// This class is supposed to handle http error codes or unexpected codes by converting the to Exceptions.
class ErrorHandler {
  final expectedCode;
  const ErrorHandler({this.expectedCode = 200});
  handle(Response response, {Function(int)? customhandler}) {
    if (expectedCode == response.statusCode) {
      return;
    }

    switch (response.statusCode) {
      case (401):
        throw ApiException.unauthorized();
      case (400):
        throw ApiException.badRequest(response.body);
      case (500):
        throw ApiException.internalServerError();
      case (403):
        throw ApiException.forbidden();
      default:
        if (customhandler != null) {
          customhandler(response.statusCode);
        }
        throw ApiException("unexpected Error", response.statusCode);
    }
  }
}
