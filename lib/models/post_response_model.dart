// To parse this JSON data, do
//
//     final postResponseModel = postResponseModelFromJson(jsonString);

import 'dart:convert';

PostResponseModel postResponseModelFromJson(String str) =>
    PostResponseModel.fromJson(json.decode(str));

String postResponseModelToJson(PostResponseModel data) =>
    json.encode(data.toJson());

class PostResponseModel {
  PostResponseModel({
    required this.success,
    this.message,
    this.data,
  });

  int success;
  dynamic message;
  dynamic data;

  factory PostResponseModel.fromJson(Map<String, dynamic> json) =>
      PostResponseModel(
          success: json["success"],
          message: json["message"],
          data: json["Data"]);

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "Data": data,
      };
}
