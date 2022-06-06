import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:restaurant_table_app/constants/api_constants.dart';
import 'package:restaurant_table_app/models/get_order_details_model.dart';
import 'package:restaurant_table_app/repository/base_repository.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_table_app/utils/network_utils.dart';

class GetOrderDetailsRepository extends BaseRepository {
  getOrderItems({required String tableCode}) async {
    try {
      String baseUrl = getBaseUrlWithPort();

      Response<dynamic> response = await dioGetRequest(
          url: baseUrl + getOrderDetailsUrl,
          queryParameters: {"TableCode": tableCode});

      debugPrint("GET ORDER ITEMS RESPONSE " + jsonEncode(response.data));

      GetOrderDetailsModel getOrderDetails =
          GetOrderDetailsModel.fromJson(response.data);

      return getOrderDetails;
    } on DioError catch (dioError) {
      debugPrint(dioError.toString());
      final String errorMessage = NetworkUtils.getDioErrormessage(dioError);
      throw errorMessage;
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('ERROR IN GetOrderDetailsRepository');
      rethrow;
    }
  }
}
