import 'package:dio/dio.dart';
import 'package:restaurant_table_app/main.dart';
import '../utils/network_utils.dart';
import 'package:flutter/material.dart';

class BaseRepository {
  final Dio _dio = NetworkUtils.getDio();

  // get header for http request
  getHeader() {
    return Options(
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
  }

  String getBaseUrlWithPort() {
    String baseUrl = "";

    baseUrl = "http://" + box.get("baseUrl") + ":" + box.get("port");

    return baseUrl;
  }

  ///BASE GET REQUEST
  Future<Response<dynamic>> dioGetRequest({
    @required String? url,
    Map<String, dynamic>? queryParameters,
  }) async {
    Response<dynamic> response = await _dio.get(
      url!,
      options: getHeader(),
      queryParameters: queryParameters,
    );
    return response;
  }

  ///BASE POST REQUEST
  Future<Response<dynamic>> dioPostRequest({
    @required String? url,
    @required Map<String, dynamic>? requestBody,
  }) async {
    Response<dynamic> response = await _dio.post(
      url!,
      options: getHeader(),
      data: requestBody,
    );
    return response;
  }
}
