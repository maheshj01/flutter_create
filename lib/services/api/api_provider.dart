import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_template/services/api/exception.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_template/constants/constants.dart' show BASE_URL;

enum HttpMethod { GET, POST, PUT, DELETE, PATCH }

class ApiProvider {
  static String baseUrl = BASE_URL;
  static Duration timeoutDuration = Duration(seconds: 5);

  FutureOr<void> retryOnTimeOut({http.Response response}) async {
    try {
      final res = await response.request.send();
      final newResponse = await http.Response.fromStream(res);
      handleResponse(newResponse);
    } catch (_) {}
  }

  handleResponse(http.Response res) {
    switch (res.statusCode) {
      case 200:
        return json.decode(res.body);
        break;
      case 400:
        return BadRequestException();
        break;
      case 404:
        return ResourceNotFoundException();
        break;
      case 500:
        break;
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${res.statusCode}');
    }
  }

  Future<http.Response> getRequest(String endPoint,
      {Map<String, dynamic> headers}) async {
    var responseJson;
    try {
      final response = await http
          .get(BASE_URL + endPoint, headers: headers)
          .timeout(timeoutDuration);
      responseJson = handleResponse(response);
    } on SocketException catch (_) {
      throw ConnectivityException('No Internet connection');
    } on TimeoutException catch (_) {
      // TODO: how to pass the response object on Timeout
      // retryOnTimeOut(response: http.);
    } catch (_) {}
    return responseJson;
  }

  Future<http.Response> postRequest(String endPoint,
      {Map<String, dynamic> body, Map<String, dynamic> headers}) async {
    var responseJson;
    try {
      final response = await http
          .post(BASE_URL + endPoint, body: body, headers: headers)
          .timeout(timeoutDuration);
      responseJson = handleResponse(response);
    } on SocketException catch (_) {
      throw ConnectivityException('No Internet connection');
    } on TimeoutException catch (_) {
      // TODO: how to pass the response object on Timeout
      // retryOnTimeOut(response: http.);
    } catch (_) {}
    return responseJson;
  }

  Future<http.Response> putRequest(String endPoint,
      {Map<String, dynamic> body, Map<String, dynamic> headers}) async {
    var responseJson;
    try {
      final response = await http
          .put(BASE_URL + endPoint, body: body, headers: headers)
          .timeout(timeoutDuration);
      responseJson = handleResponse(response);
    } on SocketException catch (_) {
      throw ConnectivityException('No Internet connection');
    } on TimeoutException catch (_) {
      // TODO: how to pass the response object on Timeout
      // retryOnTimeOut(response: http.);
    } catch (_) {}
    return responseJson;
  }

  Future<http.Response> deleteRequest(String endPoint,
      {Map<String, dynamic> body, Map<String, dynamic> headers}) async {
    var responseJson;
    try {
      final response = await http
          .delete(BASE_URL + endPoint, headers: headers)
          .timeout(timeoutDuration);
      responseJson = handleResponse(response);
    } on SocketException catch (_) {
      throw ConnectivityException('No Internet connection');
    } on TimeoutException catch (_) {
      // TODO: how to pass the response object on Timeout
      // retryOnTimeOut(response: http.);
    } catch (_) {}
    return responseJson;
  }

  Future<http.Response> patchRequest(String endPoint,
      {Map<String, dynamic> body, Map<String, dynamic> headers}) async {
    final response = await http.patch(BASE_URL + endPoint);
    var responseJson;
    try {
      final response = await http
          .patch(BASE_URL + endPoint, body: body, headers: headers)
          .timeout(timeoutDuration);
      responseJson = handleResponse(response);
    } on SocketException catch (_) {
      throw ConnectivityException('No Internet connection');
    } on TimeoutException catch (_) {
      // TODO: how to pass the response object on Timeout
      // retryOnTimeOut(response: http.);
    } catch (_) {}
    return responseJson;
  }
}
