// To parse this JSON data, do
//
//     final getItemsListModel = getItemsListModelFromJson(jsonString);
import 'package:flutter/material.dart';
import 'dart:convert';

GetItemsListModel getItemsListModelFromJson(String str) =>
    GetItemsListModel.fromJson(json.decode(str));

String getItemsListModelToJson(GetItemsListModel data) =>
    json.encode(data.toJson());

class GetItemsListModel {
  GetItemsListModel({
    this.success,
    this.message,
    this.data,
  });

  int? success;
  String? message;
  List<ItemsListDatum>? data;

  factory GetItemsListModel.fromJson(Map<String, dynamic> json) =>
      GetItemsListModel(
        success: json["success"],
        message: json["message"],
        data: List<ItemsListDatum>.from(
            json["Data"].map((x) => ItemsListDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ItemsListDatum {
  ItemsListDatum(
      {@required this.itemCode,
      @required this.itemName,
      @required this.unitCode,
      @required this.salesRate,
      @required this.itemImage});

  int? itemCode;
  String? itemName;
  String? unitCode;
  int? salesRate;
  String? itemImage;

  factory ItemsListDatum.fromJson(Map<String, dynamic> json) => ItemsListDatum(
        itemCode: json["ITEM_CODE"],
        itemName: json["ITEM_NAME"],
        unitCode: json["UNIT_CODE"],
        salesRate: json["SALES_RATE"],

        //TODO dynamic item image
        itemImage: json[""],
      );

  Map<String, dynamic> toJson() => {
        "ITEM_CODE": itemCode,
        "ITEM_NAME": itemName,
        "UNIT_CODE": unitCode,
        "SALES_RATE": salesRate,
      };
}
