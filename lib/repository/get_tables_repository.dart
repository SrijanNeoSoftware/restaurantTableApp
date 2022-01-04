import 'package:dio/dio.dart';
import 'package:restaurant_table_app/constants/api_constants.dart';
import 'package:restaurant_table_app/models/get_tables_list_model.dart';
import 'package:restaurant_table_app/repository/base_repository.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_table_app/utils/network_utils.dart';

class GetTablesListRepository extends BaseRepository {
  getTablesList() async {
    try {
      Response<dynamic> response = await dioGetRequest(
        url: getTablesUrl,
      );

      GetTableListModel getTableList =
          GetTableListModel.fromJson(response.data);

      return getTableList;
    } on DioError catch (dioError) {
      debugPrint(dioError.toString());
      final String errorMessage = NetworkUtils.getDioErrormessage(dioError);
      throw errorMessage;
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('ERROR IN GetTablesListRepository');
      rethrow;
    }
  }
}
