// To parse this JSON data, do
//
//     final getOrderDetailsModel = getOrderDetailsModelFromJson(jsonString);

import 'dart:convert';

GetOrderDetailsModel getOrderDetailsModelFromJson(String str) =>
    GetOrderDetailsModel.fromJson(json.decode(str));

String getOrderDetailsModelToJson(GetOrderDetailsModel data) =>
    json.encode(data.toJson());

class GetOrderDetailsModel {
  GetOrderDetailsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  int success;
  String message;
  List<GetOrderDetailsDatum> data;

  factory GetOrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      GetOrderDetailsModel(
        success: json["success"],
        message: json["message"],
        data: List<GetOrderDetailsDatum>.from(
            json["Data"].map((x) => GetOrderDetailsDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetOrderDetailsDatum {
  GetOrderDetailsDatum({
    required this.itemName,
    required this.quantity,
    required this.amount,
    required this.transactionNo,
    required this.serialNo,
    required this.rate,
  });

  String itemName;
  int quantity;
  int amount;
  String transactionNo;
  int serialNo;
  int rate;

  factory GetOrderDetailsDatum.fromJson(Map<String, dynamic> json) =>
      GetOrderDetailsDatum(
        itemName: json["ITEM_NAME"],
        quantity: json["QUANTITY"],
        amount: json["AMOUNT"],
        transactionNo: json["TRANSACTION_NO"],
        serialNo: json["SERIAL_NO"],
        rate: json["RATE"],
      );

  Map<String, dynamic> toJson() => {
        "ITEM_NAME": itemName,
        "QUANTITY": quantity,
        "AMOUNT": amount,
        "TRANSACTION_NO": transactionNo,
        "SERIAL_NO": serialNo,
        "RATE": rate,
      };
}
