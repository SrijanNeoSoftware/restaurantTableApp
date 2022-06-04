import 'package:dio/dio.dart';
import 'package:restaurant_table_app/constants/api_constants.dart';
import 'package:restaurant_table_app/models/post_response_model.dart';
import 'package:restaurant_table_app/models/selected_items_list_model.dart';
import 'package:restaurant_table_app/repository/base_repository.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_table_app/utils/network_utils.dart';

class PostSalesOrderRepository extends BaseRepository {
  postSalesOrderList(
      {required List<SelectedItemsListDatum> salesOrders,
      required String paymentRemarks}) async {
    List items = [];
    try {
      for (SelectedItemsListDatum item in salesOrders) {
        items.add(
          {
            "Item_code": item.itemCode,
            "Unit_code": item.unitCode,
            "Quantity": item.qty,
            "RATE": item.salesRate,
            "AMOUNT": int.tryParse(item.qty!)! * item.salesRate!,
            "TABLE_CODE": item.tableCode,
            "Remarks": item.remarks
          },
        );
      }

      Map<String, dynamic> requestBody = {
        "SalesOrders": items,
        "SalesOrderRemarks": paymentRemarks
      };

      debugPrint("POST SALES ORDER REQUEST BODY " + requestBody.toString());

      Response<dynamic> response = await dioPostRequest(
        url: postSalesOrder,
        requestBody: requestBody,
      );
      debugPrint("POST SALES ORDER RESPONSE " + response.data.toString());

      PostResponseModel postResponse =
          PostResponseModel.fromJson(response.data);

      return postResponse;
    } on DioError catch (dioError) {
      debugPrint(dioError.toString());
      final String errorMessage = NetworkUtils.getDioErrormessage(dioError);
      throw errorMessage;
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('ERROR IN PostSalesOrderRepository');
      rethrow;
    }
  }
}
