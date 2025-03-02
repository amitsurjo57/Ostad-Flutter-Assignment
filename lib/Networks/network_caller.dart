import 'dart:convert';
import 'package:e_commerce_project/Networks/network_response.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class NetworkCaller {
  final Logger _logger = Logger();

  Future<NetworkResponse> getRequest(String url, {String? token}) async {
    try {
      Uri uri = Uri.parse(url);
      final headers = {
        'content-type': 'application/json',
      };
      if (token != null) {
        headers['token'] = token;
      }
      Response response = await get(
        uri,
        headers: headers,
      );
      debugPrint("URL => $url");
      _logResponse(url, response);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final decodedMessage = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedMessage,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      _logRequest(url, -1, null, null, e.toString());
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> postRequest(
    String url, {
    String? token,
    required Map<String, dynamic> body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      final headers = {
        'content-type': 'application/json',
      };
      if (token != null) {
        headers['token'] = token;
      }
      Response response = await post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
      debugPrint("URL => $url");
      _logResponse(url, response);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      _logRequest(url, -1, null, null, e.toString());
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  void _logRequest(String url, int statusCode, dynamic headers, dynamic body,
      [String? errorMsg]) {
    _logger.i("Url => $url");
    _logger.i("StatusCode => $statusCode");
    _logger.i("Headers => $headers");
    _logger.i("Body => $body");
    _logger.e("ErrorMessage => $errorMsg");
  }

  void _logResponse(String url, Response response) {
    _logger.i("Url => $url");
    _logger.i("StatusCode => ${response.statusCode}");
    _logger.i("headers => ${response.headers}");
    _logger.i("Body => ${response.body}");
  }
}
