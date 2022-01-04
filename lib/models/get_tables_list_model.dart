// To parse this JSON data, do
//
//     final getTableListModel = getTableListModelFromJson(jsonString);

import 'dart:convert';

GetTableListModel getTableListModelFromJson(String str) =>
    GetTableListModel.fromJson(json.decode(str));

String getTableListModelToJson(GetTableListModel data) =>
    json.encode(data.toJson());

class GetTableListModel {
  GetTableListModel({
    this.success,
    this.message,
    this.data,
  });

  int? success;
  String? message;
  List<GetTableListDatum>? data;

  factory GetTableListModel.fromJson(Map<String, dynamic> json) =>
      GetTableListModel(
        success: json["success"],
        message: json["message"],
        data: List<GetTableListDatum>.from(
            json["Data"].map((x) => GetTableListDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class GetTableListDatum {
  GetTableListDatum({
    this.tableCode,
    this.tableName,
  });

  String? tableCode;
  String? tableName;

  factory GetTableListDatum.fromJson(Map<String, dynamic> json) =>
      GetTableListDatum(
        tableCode: json["TABLE_CODE"],
        tableName: json["TABLE_NAME"],
      );

  Map<String, dynamic> toJson() => {
        "TABLE_CODE": tableCode,
        "TABLE_NAME": tableName,
      };
}
