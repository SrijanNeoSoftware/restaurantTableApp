import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_table_app/constants/api_constants.dart';
import 'package:restaurant_table_app/models/get_login_model.dart';
import 'package:restaurant_table_app/repository/base_repository.dart';
import 'package:restaurant_table_app/utils/network_utils.dart';

class GetLoginRepository extends BaseRepository {
  getLogin({required String? username, required String? password}) async {
    try {
      String baseUrl = getBaseUrlWithPort();

      Response response = await dioGetRequest(
        url: baseUrl + getLoginUrl,
        queryParameters: {
          "Username": username,
          "password": password,
        },
      );

      debugPrint("GET LOGIN RESPOSITORY " + jsonEncode(response.data));
      LoginModel loginResponse = LoginModel.fromJson(response.data);
      return loginResponse;
    } on DioError catch (dioError) {
      debugPrint(dioError.toString());
      final String errorMessage = NetworkUtils.getDioErrormessage(dioError);
      throw errorMessage;
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('ERROR IN GetLoginRepository');
      rethrow;
    }
  }
}
