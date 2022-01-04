// To parse this JSON data, do
//
//     final getItemsListModel = getItemsListModelFromJson(jsonString);

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
  ItemsListDatum({
    this.itemCode,
    this.itemName,
    this.unitCode,
    this.salesRate,
  });

  int? itemCode;
  String? itemName;
  String? unitCode;
  int? salesRate;

  factory ItemsListDatum.fromJson(Map<String, dynamic> json) => ItemsListDatum(
        itemCode: json["ITEM_CODE"],
        itemName: json["ITEM_NAME"],
        unitCode: json["UNIT_CODE"],
        salesRate: json["SALES_RATE"],
      );

  Map<String, dynamic> toJson() => {
        "ITEM_CODE": itemCode,
        "ITEM_NAME": itemName,
        "UNIT_CODE": unitCode,
        "SALES_RATE": salesRate,
      };
}
