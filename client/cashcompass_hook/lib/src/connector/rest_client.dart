import 'package:cashcompass_hook/src/connector/error_handler.dart';
import 'package:http/http.dart' as http;

class RestClient {
  final String baseUrl;
  final String? port;
  RestClient({required this.baseUrl, this.port});

  String get _basetUrl => baseUrl + (port != null ? ":$port" : "");

  Future<http.Response> get(String path,
      {Map<String, String>? headers, ErrorHandler? errorHandler}) async {
    final response =
        await http.get(Uri.parse('$_basetUrl$path'), headers: headers);
    (errorHandler ?? const ErrorHandler()).handle(response);
    return response;
  }

  Future<http.Response> post(String path, String body,
      {Map<String, String>? headers, ErrorHandler? errorHandler}) async {
    final response = await http.post(Uri.parse('$_basetUrl$path'),
        body: body,
        headers: {"content-type": "application/json", ...headers ?? {}});
    (errorHandler ?? const ErrorHandler()).handle(response);
    return response;
  }

  Future<http.Response> put(String path, String body,
      {Map<String, String>? headers, ErrorHandler? errorHandler}) async {
    final response = await http.put(
      Uri.parse('$_basetUrl$path'),
      body: body,
      headers: headers,
    );
    return response;
  }

  Future<http.Response> delete(String path,
      {Map<String, String>? headers, ErrorHandler? errorHandler}) async {
    final response =
        await http.delete(Uri.parse('$_basetUrl$path'), headers: headers);
    (errorHandler ?? const ErrorHandler()).handle(response);
    return response;
  }
}
