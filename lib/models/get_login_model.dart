// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.success,
    required this.message,
    required this.data,
  });

  int success;
  String message;
  LoginData data;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        success: json["success"],
        message: json["message"],
        data: LoginData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "Data": data.toJson(),
      };
}

class LoginData {
  LoginData({
    required this.userName,
    required this.loginCode,
  });

  String userName;
  String loginCode;

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        userName: json["USER_NAME"],
        loginCode: json["LOGIN_CODE"],
      );

  Map<String, dynamic> toJson() => {
        "USER_NAME": userName,
        "LOGIN_CODE": loginCode,
      };
}
