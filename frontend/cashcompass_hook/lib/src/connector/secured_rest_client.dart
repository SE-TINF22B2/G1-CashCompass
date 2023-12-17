import 'package:cashcompass_hook/src/connector/error_handler.dart';
import 'package:cashcompass_hook/src/connector/rest_client.dart';
import 'package:http/http.dart';

class SecuredRestClient extends RestClient {
  SecuredRestClient({required super.baseUrl, super.port});
  String? _jwt;

  String getToken(String email, String password) {
    throw Exception("Not implemented");
  }

  Map<String, String>? _addAuthHeader(Map<String, String>? headers) {
    if (headers == null && _jwt == null) {
      return null;
    }
    if (_jwt != null) {
      headers!["Authentication"] = _jwt!;
    }
    return headers;
  }

  @override
  Future<Response> get(String path,
      {Map<String, String>? headers, ErrorHandler? errorHandler}) {
    return super.get(path,
        headers: _addAuthHeader(headers), errorHandler: errorHandler);
  }

  @override
  Future<Response> post(String path, String body,
      {Map<String, String>? headers, ErrorHandler? errorHandler}) {
    return super.post(path, body,
        headers: _addAuthHeader(headers), errorHandler: errorHandler);
  }

  @override
  Future<Response> put(String path, String body,
      {Map<String, String>? headers, ErrorHandler? errorHandler}) {
    return super.put(path, body,
        headers: _addAuthHeader(headers), errorHandler: errorHandler);
  }

  @override
  Future<Response> delete(String path,
      {Map<String, String>? headers, ErrorHandler? errorHandler}) {
    return super.delete(path,
        headers: _addAuthHeader(headers), errorHandler: errorHandler);
  }
}
