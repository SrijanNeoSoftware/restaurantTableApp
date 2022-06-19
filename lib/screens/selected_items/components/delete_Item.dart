import 'package:flutter/material.dart';
import 'package:restaurant_table_app/models/get_order_details_model.dart';
import 'package:restaurant_table_app/models/post_response_model.dart';
import 'package:restaurant_table_app/repository/post_delete_items.dart';
import 'package:restaurant_table_app/utils/snackbar_utils.dart';

deleteItem(
    {required BuildContext context,
    required GetOrderDetailsDatum orderItem}) async {
  PostDeleteOrderRepository _postDeleteOrderRepository =
      PostDeleteOrderRepository();
  try {
    PostResponseModel response =
        await _postDeleteOrderRepository.postDeleteOrder(
      itemName: orderItem.itemName,
      transactionNo: orderItem.transactionNo,
      quantity: orderItem.quantity,
      amount: orderItem.amount,
      serialNo: orderItem.serialNo,
      rate: orderItem.rate,
    );

    if (response.success != 1) {
      SnackBarUtils.displaySnackBar(
          color: Colors.red,
          context: context,
          message: "Could not delete item");
    } else {
      SnackBarUtils.displaySnackBar(
          color: Colors.red, context: context, message: "Item Deleted");
    }
  } catch (e) {
    SnackBarUtils.displaySnackBar(
        color: Colors.red, context: context, message: "Could not delete item");
  }
}
