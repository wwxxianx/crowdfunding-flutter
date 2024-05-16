import 'package:dio/src/dio_exception.dart';
import 'package:flutter/foundation.dart';

class ErrorHandler implements Exception {
  String _errorMessage = "";

  ErrorHandler(this._errorMessage);

  ErrorHandler.dioException({required DioException error}) {
    _handleDioException(error);
  }

  ErrorHandler.otherException() {
    _handleOtherException();
  }

  get errorMessage {
    return _errorMessage;
  }

  // Untracked error
  _handleOtherException() {
    _errorMessage = "Something went wrong, please try again later.";
    ErrorHandler serverError = ErrorHandler(_errorMessage);
    return serverError;
  }

  // Dio Exception - tracked error
  _handleDioException(DioException error) {
    ErrorHandler serverError;
    switch (error.type) {
      case DioExceptionType.cancel:
        _errorMessage = "Request Canceled";
        serverError = ErrorHandler(_errorMessage);
        break;
      case DioExceptionType.connectionTimeout:
        _errorMessage = "Connection time out";
        serverError = ErrorHandler(_errorMessage);
        break;
      case DioExceptionType.receiveTimeout:
        _errorMessage = "Received timeout";
        serverError = ErrorHandler(_errorMessage);
        break;
      case DioExceptionType.badResponse:
        if (error.response?.statusCode == 503) {
          _errorMessage = "Something went wrong";
          serverError = ErrorHandler(_errorMessage);
        } else if (error.response?.statusCode != 401) {
          _errorMessage = handleBadRequest(error.response?.data);
          serverError = ErrorHandler(_errorMessage);
        } else {
          _errorMessage = "UnAuthorized";
          serverError = ErrorHandler(_errorMessage);
        }
        break;
      case DioExceptionType.unknown:
        _errorMessage = "Something went wrong";
        serverError = ErrorHandler(_errorMessage);
        break;
      case DioExceptionType.sendTimeout:
        if (kReleaseMode) {
          _errorMessage = "Something went wrong";
        } else {
          _errorMessage = "Received timeout";
        }
        serverError = ErrorHandler(_errorMessage);
        break;
      case DioExceptionType.connectionError:
        _errorMessage = "No Internet connection";
        serverError = ErrorHandler(_errorMessage);
        break;
      default:
        _errorMessage = error.response?.statusMessage ?? "Something went wrong";
        serverError = ErrorHandler(_errorMessage);
        break;
    }
    return serverError;
  }

  // Extract the errorMessage from JSON res body received from BE
  String handleBadRequest(Map<String, dynamic>? errorJsonData) {
    if (errorJsonData?['errorMessage'] != null) {
      return errorJsonData?['errorMessage'];
    }
    return "Something went wrong, unknown error";
  }
}
