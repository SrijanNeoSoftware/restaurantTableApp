import 'package:dio/dio.dart';

class NetworkUtils {
  static Dio? _dio;

  static getDio() {
    if (_dio == null) {
      _dio = Dio();
      _dio!.options.connectTimeout = 60000; //1 mins
      _dio!.options.receiveTimeout = 60000;
    }
    return _dio;
  }

  static String getDioErrormessage(error) {
    String errorDescription = "";
    if (error is DioError) {
      DioError dioError = error;
      switch (dioError.type) {
        case DioErrorType.sendTimeout:
          errorDescription = "Connection timed out with the server.";
          break;

        case DioErrorType.receiveTimeout:
          errorDescription = "Did not receive a response? from the server.";
          break;

        case DioErrorType.connectTimeout:
          errorDescription = "Connection timed out with the server.";
          break;

        case DioErrorType.cancel:
          errorDescription = "Request to the server was cancelled.";
          break;

        case DioErrorType.response:
          if (dioError.response?.statusCode == 400) {
            errorDescription =
                "StatusCode:${dioError.response?.statusCode}Sorry, something went wrong please try again.";
          }
          if (dioError.response?.statusCode == 401) {
            errorDescription = "Invalid Credentials!";
          }
          if (dioError.response?.statusCode == 403) {
            errorDescription =
                "StatusCode:${dioError.response?.statusCode} Sorry, the request you made is forbidden.";
          }
          if (dioError.response?.statusCode == 404) {
            errorDescription =
                "StatusCode:${dioError.response?.statusCode} Sorry, the resource you are trying to access was not found.";
          }
          if (dioError.response?.statusCode == 408) {
            errorDescription =
                "StatusCode:${dioError.response?.statusCode} Sorry, your request timed-out.";
          }
          if (dioError.response?.statusCode == 409) {
            errorDescription =
                "StatusCode:${dioError.response?.statusCode} Sorry, a request conflict occured.";
          }
          if (dioError.response?.statusCode == 500) {
            errorDescription =
                "StatusCode:${dioError.response?.statusCode} Sorry, an internal server error occured.";
          }
          if (dioError.response?.statusCode == 503) {
            errorDescription =
                "StatusCode:${dioError.response?.statusCode} Sorry, the service you are trying to access is currently unavailable.";
          }
          break;

        case DioErrorType.other:
          errorDescription = "Please check your internet connection.";
          break;
        default:
      }
    } else {
      errorDescription = "An unexpected error has occured";
    }

    return errorDescription;
  }
}
