import 'package:dio/dio.dart';
import 'package:restaurant_table_app/constants/api_constants.dart';
import 'package:restaurant_table_app/models/get_items_list_model.dart';
import 'package:restaurant_table_app/repository/base_repository.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_table_app/utils/network_utils.dart';

class GetMenuItemsRepository extends BaseRepository {
  getMenuItem() async {
    try {
      Response<dynamic> response = await dioGetRequest(
        url: getItemsUrl,
      );

      GetItemsListModel getItemList = GetItemsListModel.fromJson(response.data);

      return getItemList;
    } on DioError catch (dioError) {
      debugPrint(dioError.toString());
      final String errorMessage = NetworkUtils.getDioErrormessage(dioError);
      throw errorMessage;
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('ERROR IN GetMenuItemsRepository');
      rethrow;
    }
  }
}
