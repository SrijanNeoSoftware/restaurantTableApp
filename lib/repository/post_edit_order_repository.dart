import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:restaurant_table_app/constants/api_constants.dart';
import 'package:restaurant_table_app/models/post_response_model.dart';
import 'package:restaurant_table_app/repository/base_repository.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_table_app/utils/network_utils.dart';

class PostUpdateOrderRepository extends BaseRepository {
  postUpdateOrder(
      {required String itemName,
      required String transactionNo,
      required int quantity,
      required double amount,
      required int serialNo}) async {
    try {
      String baseUrl = getBaseUrlWithPort();

      Map<String, dynamic> requestBody = {
        "ITEM_NAME": itemName,
        "QUANTITY": quantity,
        "AMOUNT": amount,
        "TRANSACTION_NO": transactionNo,
        "SERIAL_NO": serialNo
      };

      debugPrint("POST UPDATE ORDER REQUEST BODY " + jsonEncode(requestBody));

      Response<dynamic> response = await dioPostRequest(
        url: baseUrl + postUpdateItemsUrl,
        requestBody: requestBody,
      );
      debugPrint("POST UPDATE ORDER RESPONSE " + response.data.toString());

      PostResponseModel postResponse =
          PostResponseModel.fromJson(response.data);

      return postResponse;
    } on DioError catch (dioError) {
      debugPrint(dioError.toString());
      final String errorMessage = NetworkUtils.getDioErrormessage(dioError);
      throw errorMessage;
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('ERROR IN PostUpdateOrderRepository');
      rethrow;
    }
  }
}
